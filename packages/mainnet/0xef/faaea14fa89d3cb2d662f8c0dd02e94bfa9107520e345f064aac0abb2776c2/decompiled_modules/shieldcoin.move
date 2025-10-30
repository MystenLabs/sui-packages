module 0xeffaaea14fa89d3cb2d662f8c0dd02e94bfa9107520e345f064aac0abb2776c2::shieldcoin {
    struct SHIELDCOIN has drop {
        dummy_field: bool,
    }

    struct ShieldPool has key {
        id: 0x2::object::UID,
        treasury: 0x2::coin::TreasuryCap<SHIELDCOIN>,
        dev_fees: u64,
        total_supply: u64,
        pvk: vector<u8>,
    }

    struct ShieldedNote has store, key {
        id: 0x2::object::UID,
        commitment: vector<u8>,
        nullifier: vector<u8>,
    }

    public fun mint(arg0: &mut ShieldPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.total_supply + arg1 <= 21000000000000000, 1);
        arg0.total_supply = arg0.total_supply + arg1;
        0x2::transfer::public_transfer<0x2::coin::Coin<SHIELDCOIN>>(0x2::coin::mint<SHIELDCOIN>(&mut arg0.treasury, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: SHIELDCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SHIELDCOIN>(arg0, 9, 0x1::string::utf8(b"SEC"), 0x1::string::utf8(b"Scash"), 0x1::string::utf8(b"Private SEC on Sui with zk-SNARKs, 21M max supply"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_freeze_object<0x2::coin_registry::MetadataCap<SHIELDCOIN>>(0x2::coin_registry::finalize<SHIELDCOIN>(v0, arg1));
        let v2 = ShieldPool{
            id           : 0x2::object::new(arg1),
            treasury     : v1,
            dev_fees     : 0,
            total_supply : 0,
            pvk          : x"0102030405060708090a",
        };
        0x2::transfer::share_object<ShieldPool>(v2);
    }

    public fun shield_with_proof(arg0: 0x2::coin::Coin<SHIELDCOIN>, arg1: &mut ShieldPool, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<SHIELDCOIN>(&arg0);
        let v1 = v0 * 30 / 10000;
        let v2 = v0 - v1;
        0x2::coin::burn<SHIELDCOIN>(&mut arg1.treasury, arg0);
        let v3 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<u64>(&v2));
        0x1::vector::append<u8>(&mut v3, arg4);
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<address>(&arg5));
        let v4 = ShieldedNote{
            id         : 0x2::object::new(arg6),
            commitment : 0x2::hash::keccak256(&v3),
            nullifier  : 0x2::hash::keccak256(&arg4),
        };
        0x2::transfer::public_transfer<ShieldedNote>(v4, arg5);
        arg1.dev_fees = arg1.dev_fees + v1;
    }

    public fun withdraw_fees(arg0: &mut ShieldPool, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == @0x2c478b5f158e037cb21b3443a5a3512f6fee0b9a16d7a261baa00ddca69d6fc5, 0);
        let v1 = arg0.dev_fees;
        assert!(arg0.total_supply + v1 <= 21000000000000000, 1);
        arg0.dev_fees = 0;
        arg0.total_supply = arg0.total_supply + v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<SHIELDCOIN>>(0x2::coin::mint<SHIELDCOIN>(&mut arg0.treasury, v1, arg1), v0);
    }

    // decompiled from Move bytecode v6
}

