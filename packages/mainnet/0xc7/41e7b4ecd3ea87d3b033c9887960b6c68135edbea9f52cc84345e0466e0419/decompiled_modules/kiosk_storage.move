module 0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::kiosk_storage {
    struct KioskStorage has store {
        owner_cap: 0x2::kiosk::KioskOwnerCap,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        nft_default_price: u64,
    }

    public(friend) fun new(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : KioskStorage {
        let (v0, v1) = 0x2::kiosk::new(arg1);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v0);
        KioskStorage{
            owner_cap         : v1,
            balance           : 0x2::balance::zero<0x2::sui::SUI>(),
            nft_default_price : arg0,
        }
    }

    public(friend) fun withdraw<T0: store + key>(arg0: &mut KioskStorage, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) : (T0, 0x2::transfer_policy::TransferRequest<T0>) {
        let v0 = arg0.nft_default_price;
        assert_enough_sui_in_kiosk_storage(arg0, v0);
        0x2::kiosk::list<T0>(arg1, &arg0.owner_cap, arg2, v0);
        if (v0 == 0) {
            return 0x2::kiosk::purchase<T0>(arg1, arg2, 0x2::coin::zero<0x2::sui::SUI>(arg3))
        };
        let (v1, v2) = 0x2::kiosk::purchase<T0>(arg1, arg2, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, arg0.nft_default_price), arg3));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::kiosk::withdraw(arg1, &arg0.owner_cap, 0x1::option::none<u64>(), arg3)));
        (v1, v2)
    }

    fun assert_enough_sui_in_kiosk_storage(arg0: &KioskStorage, arg1: u64) {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.balance) >= arg1, 0);
    }

    public(friend) fun deposit<T0: store + key>(arg0: &KioskStorage, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::transfer_policy::TransferPolicy<T0>, arg3: T0) {
        0x2::kiosk::lock<T0>(arg1, &arg0.owner_cap, arg2, arg3);
    }

    public(friend) fun deposit_sui(arg0: &mut KioskStorage, arg1: 0x2::balance::Balance<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, arg1);
    }

    public(friend) fun is_correct_kiosk(arg0: &KioskStorage, arg1: &mut 0x2::kiosk::Kiosk) : bool {
        0x2::kiosk::has_access(arg1, &arg0.owner_cap)
    }

    public(friend) fun set_nft_default_price(arg0: &mut KioskStorage, arg1: u64) {
        arg0.nft_default_price = arg1;
    }

    public(friend) fun withdraw_sui(arg0: &mut KioskStorage, arg1: u64) : 0x2::balance::Balance<0x2::sui::SUI> {
        assert_enough_sui_in_kiosk_storage(arg0, arg1);
        0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, arg1)
    }

    // decompiled from Move bytecode v6
}

