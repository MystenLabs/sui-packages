module 0x38558fa27e6bc0e81f0b2cb84083a5ebafb50f1460b80c2b74e29f74ab1cf63c::wave_vesting {
    struct App has key {
        id: 0x2::object::UID,
        version: u8,
        is_paused: bool,
    }

    struct UserData has store, key {
        id: 0x2::object::UID,
        beneficiary: address,
        vesting_infos: vector<VestingInfo>,
    }

    struct VestingInfo has store {
        beneficiary: address,
        balance: 0x2::balance::Balance<0x82616322719cb327186d5b83a6d7783ce5cef4c5dbd4c6d1b5f3d6e5d288e2be::wav::WAV>,
        genesis_timestamp: u64,
        total_amount: u64,
        cliff: u64,
        period: u64,
        duration: u64,
        tge_amount: u64,
        participant: u8,
        status: u8,
    }

    struct BeneficiaryAdded has copy, drop, store {
        beneficiary: address,
        index: u64,
        participant: u8,
        total_amount: u64,
        cliff: u64,
        period: u64,
        duration: u64,
        tge_amount: u64,
        status: u8,
    }

    struct VestingStatusUpdated has copy, drop, store {
        is_paused: bool,
    }

    struct BeneficiaryStatusUpdated has copy, drop, store {
        beneficiary: address,
        index: u64,
        status: u8,
    }

    struct EmergencyWithdraw has copy, drop, store {
        beneficiary: address,
        index: u64,
        amount: u64,
    }

    struct TokenClaim has copy, drop, store {
        beneficiary: address,
        index: u64,
        participant: u8,
        amount: u64,
    }

    struct OwnerCap has key {
        id: 0x2::object::UID,
    }

    entry fun add_beneficiary(arg0: &OwnerCap, arg1: &mut App, arg2: address, arg3: 0x2::coin::Coin<0x82616322719cb327186d5b83a6d7783ce5cef4c5dbd4c6d1b5f3d6e5d288e2be::wav::WAV>, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u8, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version <= 1, 2);
        let v0 = 0x2::coin::value<0x82616322719cb327186d5b83a6d7783ce5cef4c5dbd4c6d1b5f3d6e5d288e2be::wav::WAV>(&arg3);
        assert!(v0 >= arg8, 0);
        if (!0x2::dynamic_object_field::exists_with_type<address, UserData>(&arg1.id, arg2)) {
            let v1 = UserData{
                id            : 0x2::object::new(arg10),
                beneficiary   : arg2,
                vesting_infos : 0x1::vector::empty<VestingInfo>(),
            };
            0x2::dynamic_object_field::add<address, UserData>(&mut arg1.id, arg2, v1);
        };
        let v2 = 0x2::dynamic_object_field::borrow_mut<address, UserData>(&mut arg1.id, arg2);
        let v3 = VestingInfo{
            beneficiary       : arg2,
            balance           : 0x2::coin::into_balance<0x82616322719cb327186d5b83a6d7783ce5cef4c5dbd4c6d1b5f3d6e5d288e2be::wav::WAV>(arg3),
            genesis_timestamp : arg4,
            total_amount      : v0,
            cliff             : arg5,
            period            : arg6,
            duration          : arg7,
            tge_amount        : arg8,
            participant       : arg9,
            status            : 1,
        };
        0x1::vector::push_back<VestingInfo>(&mut v2.vesting_infos, v3);
        let v4 = BeneficiaryAdded{
            beneficiary  : arg2,
            index        : 0x1::vector::length<VestingInfo>(&v2.vesting_infos),
            participant  : arg9,
            total_amount : v0,
            cliff        : arg5,
            period       : arg6,
            duration     : arg7,
            tge_amount   : arg8,
            status       : 1,
        };
        0x2::event::emit<BeneficiaryAdded>(v4);
    }

    entry fun claim(arg0: &mut App, arg1: address, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version <= 1, 2);
        assert!(!arg0.is_paused, 1);
        assert!(0x2::dynamic_object_field::exists_with_type<address, UserData>(&arg0.id, arg1), 3);
        let v0 = 0x2::dynamic_object_field::borrow_mut<address, UserData>(&mut arg0.id, arg1);
        assert!(arg2 < 0x1::vector::length<VestingInfo>(&v0.vesting_infos), 4);
        let v1 = 0x1::vector::borrow_mut<VestingInfo>(&mut v0.vesting_infos, arg2);
        let v2 = claimable_amount(v1.genesis_timestamp, v1.total_amount, v1.cliff, v1.duration, v1.period, v1.tge_amount, v1.total_amount - 0x2::balance::value<0x82616322719cb327186d5b83a6d7783ce5cef4c5dbd4c6d1b5f3d6e5d288e2be::wav::WAV>(&v1.balance), v1.status, arg3);
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x82616322719cb327186d5b83a6d7783ce5cef4c5dbd4c6d1b5f3d6e5d288e2be::wav::WAV>>(0x2::coin::from_balance<0x82616322719cb327186d5b83a6d7783ce5cef4c5dbd4c6d1b5f3d6e5d288e2be::wav::WAV>(0x2::balance::split<0x82616322719cb327186d5b83a6d7783ce5cef4c5dbd4c6d1b5f3d6e5d288e2be::wav::WAV>(&mut v1.balance, v2), arg4), arg1);
            let v3 = TokenClaim{
                beneficiary : v1.beneficiary,
                index       : arg2,
                participant : v1.participant,
                amount      : v2,
            };
            0x2::event::emit<TokenClaim>(v3);
        };
    }

    fun claimable_amount(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u8, arg8: &0x2::clock::Clock) : u64 {
        if (0x2::clock::timestamp_ms(arg8) < arg0 || arg7 == 0) {
            return 0
        };
        vested_amount(arg0, arg1, arg2, arg3, arg4, arg5, arg8) - arg6
    }

    entry fun emergency_withdraw(arg0: &OwnerCap, arg1: &mut App, arg2: address, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version <= 1, 2);
        assert!(0x2::dynamic_object_field::exists_with_type<address, UserData>(&arg1.id, arg2), 3);
        let v0 = 0x2::dynamic_object_field::borrow_mut<address, UserData>(&mut arg1.id, arg2);
        assert!(arg3 < 0x1::vector::length<VestingInfo>(&v0.vesting_infos), 4);
        let v1 = 0x1::vector::borrow_mut<VestingInfo>(&mut v0.vesting_infos, arg3);
        assert!(0x2::balance::value<0x82616322719cb327186d5b83a6d7783ce5cef4c5dbd4c6d1b5f3d6e5d288e2be::wav::WAV>(&v1.balance) >= arg4, 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x82616322719cb327186d5b83a6d7783ce5cef4c5dbd4c6d1b5f3d6e5d288e2be::wav::WAV>>(0x2::coin::from_balance<0x82616322719cb327186d5b83a6d7783ce5cef4c5dbd4c6d1b5f3d6e5d288e2be::wav::WAV>(0x2::balance::split<0x82616322719cb327186d5b83a6d7783ce5cef4c5dbd4c6d1b5f3d6e5d288e2be::wav::WAV>(&mut v1.balance, arg4), arg5), 0x2::tx_context::sender(arg5));
        let v2 = EmergencyWithdraw{
            beneficiary : arg2,
            index       : arg3,
            amount      : arg4,
        };
        0x2::event::emit<EmergencyWithdraw>(v2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = App{
            id        : 0x2::object::new(arg0),
            version   : 1,
            is_paused : false,
        };
        0x2::transfer::share_object<App>(v0);
        let v1 = OwnerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<OwnerCap>(v1, 0x2::tx_context::sender(arg0));
    }

    entry fun update_beneficiary_status(arg0: &OwnerCap, arg1: &mut App, arg2: address, arg3: u64, arg4: u8) {
        assert!(arg1.version <= 1, 2);
        assert!(0x2::dynamic_object_field::exists_with_type<address, UserData>(&arg1.id, arg2), 3);
        let v0 = 0x2::dynamic_object_field::borrow_mut<address, UserData>(&mut arg1.id, arg2);
        assert!(arg3 < 0x1::vector::length<VestingInfo>(&v0.vesting_infos), 4);
        0x1::vector::borrow_mut<VestingInfo>(&mut v0.vesting_infos, arg3).status = arg4;
        let v1 = BeneficiaryStatusUpdated{
            beneficiary : arg2,
            index       : arg3,
            status      : arg4,
        };
        0x2::event::emit<BeneficiaryStatusUpdated>(v1);
    }

    entry fun update_vesting_status(arg0: &OwnerCap, arg1: &mut App, arg2: bool) {
        assert!(arg1.version <= 1, 2);
        arg1.is_paused = arg2;
        let v0 = VestingStatusUpdated{is_paused: arg2};
        0x2::event::emit<VestingStatusUpdated>(v0);
    }

    fun vested_amount(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg6) - arg0;
        if (v0 < arg2) {
            return arg5
        };
        if (v0 >= arg2 + arg3) {
            return arg1
        };
        (arg1 - arg5) * ((v0 - arg2) / arg4 + 1) / ((arg3 + arg4 - 1) / arg4 + 1) + arg5
    }

    // decompiled from Move bytecode v6
}

