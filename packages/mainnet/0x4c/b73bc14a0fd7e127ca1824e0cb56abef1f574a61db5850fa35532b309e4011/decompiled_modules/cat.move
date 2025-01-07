module 0x4cb73bc14a0fd7e127ca1824e0cb56abef1f574a61db5850fa35532b309e4011::cat {
    struct CAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAT>(arg0, 6, b"CAT", b"CAT SUI", b"Cat is a Community driven fun and exciting memecoin on Sui! we plan to bring the times of big moonshots back to Sui! Cat welcomes all whales and investors to join us and make Sui Great again!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_13_00_37_06_a85d6d7b6f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

