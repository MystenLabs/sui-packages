module 0x1712760d75aa21c919d9da29f99a71ae61b4277a74c1f05cbbcf04319ca6d3a::shieldcoin {
    struct SHIELDCOIN has drop {
        dummy_field: bool,
    }

    struct ShieldPool has key {
        id: 0x2::object::UID,
        treasury: 0x2::coin::TreasuryCap<SHIELDCOIN>,
        dev_fees: u64,
        pvk: vector<u8>,
    }

    struct ShieldedNote has store, key {
        id: 0x2::object::UID,
        commitment: vector<u8>,
        nullifier: vector<u8>,
    }

    public fun mint(arg0: &mut ShieldPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SHIELDCOIN>>(0x2::coin::mint<SHIELDCOIN>(&mut arg0.treasury, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: SHIELDCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SHIELDCOIN>(arg0, 9, 0x1::string::utf8(b"ZEC"), 0x1::string::utf8(b"ShieldCoin"), 0x1::string::utf8(b"Private ZEC on Sui with zk-SNARKs"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_freeze_object<0x2::coin_registry::MetadataCap<SHIELDCOIN>>(0x2::coin_registry::finalize<SHIELDCOIN>(v0, arg1));
        let v2 = ShieldPool{
            id       : 0x2::object::new(arg1),
            treasury : v1,
            dev_fees : 0,
            pvk      : x"0102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f20",
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
        assert!(v0 == @0x62e5de0350f900cfa50e576f43bfc677174f31e51065f58a1010e1556762e2be, 0);
        arg0.dev_fees = 0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SHIELDCOIN>>(0x2::coin::mint<SHIELDCOIN>(&mut arg0.treasury, arg0.dev_fees, arg1), v0);
    }

    // decompiled from Move bytecode v6
}

