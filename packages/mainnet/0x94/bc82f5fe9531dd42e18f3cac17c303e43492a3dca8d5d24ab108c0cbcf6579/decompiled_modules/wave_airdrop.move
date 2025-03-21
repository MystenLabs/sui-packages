module 0x94bc82f5fe9531dd42e18f3cac17c303e43492a3dca8d5d24ab108c0cbcf6579::wave_airdrop {
    struct App has key {
        id: 0x2::object::UID,
        operator_pk: vector<u8>,
        balance: 0x2::balance::Balance<0x82616322719cb327186d5b83a6d7783ce5cef4c5dbd4c6d1b5f3d6e5d288e2be::wav::WAV>,
        version: u8,
        paused: bool,
        max_claim_amount: u64,
    }

    struct WaveAirdropClaimed has copy, drop, store {
        receiver: address,
        id: u64,
        amount: u64,
        unlock_time: u64,
    }

    struct OwnerCap has key {
        id: 0x2::object::UID,
    }

    entry fun admin_deposit(arg0: &OwnerCap, arg1: &mut App, arg2: 0x2::coin::Coin<0x82616322719cb327186d5b83a6d7783ce5cef4c5dbd4c6d1b5f3d6e5d288e2be::wav::WAV>) {
        0x2::balance::join<0x82616322719cb327186d5b83a6d7783ce5cef4c5dbd4c6d1b5f3d6e5d288e2be::wav::WAV>(&mut arg1.balance, 0x2::coin::into_balance<0x82616322719cb327186d5b83a6d7783ce5cef4c5dbd4c6d1b5f3d6e5d288e2be::wav::WAV>(arg2));
    }

    entry fun admin_unpause(arg0: &OwnerCap, arg1: &mut App) {
        arg1.paused = false;
    }

    entry fun admin_update_max_claim_amount(arg0: &OwnerCap, arg1: &mut App, arg2: u64) {
        arg1.max_claim_amount = arg2;
    }

    entry fun admin_withdraw(arg0: &OwnerCap, arg1: &mut App, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x82616322719cb327186d5b83a6d7783ce5cef4c5dbd4c6d1b5f3d6e5d288e2be::wav::WAV>(&arg1.balance) >= arg2, 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x82616322719cb327186d5b83a6d7783ce5cef4c5dbd4c6d1b5f3d6e5d288e2be::wav::WAV>>(0x2::coin::from_balance<0x82616322719cb327186d5b83a6d7783ce5cef4c5dbd4c6d1b5f3d6e5d288e2be::wav::WAV>(0x2::balance::split<0x82616322719cb327186d5b83a6d7783ce5cef4c5dbd4c6d1b5f3d6e5d288e2be::wav::WAV>(&mut arg1.balance, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    entry fun claim(arg0: &mut App, arg1: u64, arg2: u64, arg3: address, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 7);
        assert!(arg0.version <= 1, 3);
        validate_signature(arg0.operator_pk, arg3, arg1, arg2, arg4, arg5, arg6, arg7);
        assert!(!0x2::dynamic_field::exists_<u64>(&arg0.id, arg1), 5);
        0x2::dynamic_field::add<u64, bool>(&mut arg0.id, arg1, true);
        assert!(arg2 <= arg0.max_claim_amount, 8);
        assert!(0x2::balance::value<0x82616322719cb327186d5b83a6d7783ce5cef4c5dbd4c6d1b5f3d6e5d288e2be::wav::WAV>(&arg0.balance) >= arg2, 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x82616322719cb327186d5b83a6d7783ce5cef4c5dbd4c6d1b5f3d6e5d288e2be::wav::WAV>>(0x2::coin::from_balance<0x82616322719cb327186d5b83a6d7783ce5cef4c5dbd4c6d1b5f3d6e5d288e2be::wav::WAV>(0x2::balance::split<0x82616322719cb327186d5b83a6d7783ce5cef4c5dbd4c6d1b5f3d6e5d288e2be::wav::WAV>(&mut arg0.balance, arg2), arg8), arg3);
        let v0 = WaveAirdropClaimed{
            receiver    : arg3,
            id          : arg1,
            amount      : arg2,
            unlock_time : arg4,
        };
        0x2::event::emit<WaveAirdropClaimed>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = @0xe23ea84b1a5eadf24ba8613d9b0e05a34a22b7daf1d34f2fef3012537026ead5;
        let v1 = App{
            id               : 0x2::object::new(arg0),
            operator_pk      : 0x2::bcs::to_bytes<address>(&v0),
            balance          : 0x2::balance::zero<0x82616322719cb327186d5b83a6d7783ce5cef4c5dbd4c6d1b5f3d6e5d288e2be::wav::WAV>(),
            version          : 1,
            paused           : false,
            max_claim_amount : 0,
        };
        0x2::transfer::share_object<App>(v1);
        let v2 = OwnerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<OwnerCap>(v2, 0x2::tx_context::sender(arg0));
    }

    entry fun migrate(arg0: &OwnerCap, arg1: &mut App) {
        assert!(arg1.version < 1, 2);
        arg1.version = 1;
    }

    entry fun operator_pause(arg0: &mut App, arg1: u64, arg2: vector<u8>, arg3: &0x2::clock::Clock) {
        let v0 = 0x1::string::utf8(b"WAVE_AIRDROP_PAUSE:");
        let v1 = 0x2::bcs::to_bytes<0x1::string::String>(&v0);
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<0x2::object::UID>(&arg0.id));
        let v2 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<0x1::string::String>(&v2));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg1));
        assert!(0x2::ed25519::ed25519_verify(&arg2, &arg0.operator_pk, &v1) == true, 1);
        assert!(0x2::clock::timestamp_ms(arg3) < arg1, 6);
        arg0.paused = true;
    }

    entry fun update_operator(arg0: &OwnerCap, arg1: &mut App, arg2: vector<u8>) {
        arg1.operator_pk = arg2;
    }

    fun validate_signature(arg0: vector<u8>, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: &0x2::clock::Clock) {
        let v0 = 0x1::string::utf8(b"WAVE_AIRDROP_CLAIM:");
        let v1 = 0x2::bcs::to_bytes<0x1::string::String>(&v0);
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<address>(&arg1));
        let v2 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<0x1::string::String>(&v2));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg2));
        let v3 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<0x1::string::String>(&v3));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg3));
        let v4 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<0x1::string::String>(&v4));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg4));
        let v5 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<0x1::string::String>(&v5));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg5));
        assert!(0x2::ed25519::ed25519_verify(&arg6, &arg0, &v1) == true, 1);
        let v6 = 0x2::clock::timestamp_ms(arg7);
        assert!(v6 < arg5, 6);
        assert!(v6 >= arg4, 9);
    }

    // decompiled from Move bytecode v6
}

