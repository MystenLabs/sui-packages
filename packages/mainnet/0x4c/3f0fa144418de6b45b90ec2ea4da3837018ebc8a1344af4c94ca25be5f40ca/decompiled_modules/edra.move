module 0x4c3f0fa144418de6b45b90ec2ea4da3837018ebc8a1344af4c94ca25be5f40ca::edra {
    struct EDRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: EDRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EDRA>(arg0, 6, b"EDRA", b"Edra", b"Edra is a MEME token full of fun, join our community and feel the glory and joy of the people behind the MEME culture", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1726757300211_b4da56d3b5a9bf4e43bc1a69080c12cc_2385a3d570.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EDRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EDRA>>(v1);
    }

    // decompiled from Move bytecode v6
}

