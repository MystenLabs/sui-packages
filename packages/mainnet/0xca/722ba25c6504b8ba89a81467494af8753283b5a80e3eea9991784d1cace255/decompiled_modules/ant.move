module 0xca722ba25c6504b8ba89a81467494af8753283b5a80e3eea9991784d1cace255::ant {
    struct ANT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANT>(arg0, 6, b"ANT", b"ANTSUI", b"we small but we many", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4858_b7802fe1fb.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANT>>(v1);
    }

    // decompiled from Move bytecode v6
}

