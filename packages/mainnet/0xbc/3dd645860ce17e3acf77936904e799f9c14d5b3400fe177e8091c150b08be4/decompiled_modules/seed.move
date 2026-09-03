module 0xbc3dd645860ce17e3acf77936904e799f9c14d5b3400fe177e8091c150b08be4::seed {
    struct SEED has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEED, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(@0x53f4e0654cdd1d3227e69c134bf642a7cf5ca8df1d761462db5b92f04e5e346c != @0x0, 1);
        assert!(@0x50316a06e622389fc06414a48974f27e9ac0be74747289d2bc4bfc471c662891 != @0x0, 1);
        assert!(@0xa5b86e365cb0a571ebef005283710f7afc55d3be178ad467f8924cab81ed646d != @0x0, 1);
        let v0 = b"https://myseeder.xyz/images/seed_icon.png";
        assert!(0x1::vector::length<u8>(&v0) > 0, 2);
        let (v1, v2) = 0x2::coin_registry::new_currency_with_otw<SEED>(arg0, 0, 0x1::string::utf8(b"SEED"), 0x1::string::utf8(b"Seeder"), 0x1::string::utf8(b"SEED is the official token of Seeder, a crypto recovery project focused on secure seed backup, long-term access, and wallet recovery. Learn more at myseeder.xyz."), 0x1::string::utf8(b"https://myseeder.xyz/images/seed_icon.png"), arg1);
        let v3 = v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<SEED>>(0x2::coin::mint<SEED>(&mut v3, 1000000, arg1), @0x53f4e0654cdd1d3227e69c134bf642a7cf5ca8df1d761462db5b92f04e5e346c);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<SEED>>(0x2::coin_registry::finalize<SEED>(v1, arg1), @0xa5b86e365cb0a571ebef005283710f7afc55d3be178ad467f8924cab81ed646d);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEED>>(v3, @0x50316a06e622389fc06414a48974f27e9ac0be74747289d2bc4bfc471c662891);
    }

    // decompiled from Move bytecode v7
}

