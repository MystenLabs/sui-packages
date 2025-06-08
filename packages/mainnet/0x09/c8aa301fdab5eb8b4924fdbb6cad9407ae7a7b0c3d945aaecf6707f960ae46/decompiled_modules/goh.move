module 0x9c8aa301fdab5eb8b4924fdbb6cad9407ae7a7b0c3d945aaecf6707f960ae46::goh {
    struct GOH has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOH>(arg0, 6, b"GOH", b"Van Gohmon", b"Art Designed by the Legend Van Gogh himself", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/log_A_3_e061e8e96f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOH>>(v1);
    }

    // decompiled from Move bytecode v6
}

