module 0x21da4dc298a83df6a32c8b7c6d98ff2a00ec690f12191f113f0002273a87e3eb::map {
    struct MAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAP>(arg0, 6, b"MAP", b"MAGAMAP", b"MAGA BABY LETS TAKE OVER THE WORLD. FIGHT FIGHT FIGHT FOR YOUR HUMAN RIGHTS.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/tumblr_190d3fbe8258ab2e9cc9dac0d93cbd69_8dc6805b_1280_8aec2b2e0b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAP>>(v1);
    }

    // decompiled from Move bytecode v6
}

