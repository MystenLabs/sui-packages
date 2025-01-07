module 0x2ad07393dcf35cb51c15462f383e1016a8ab4f127febd3d3a01b522148f3c8f7::four22 {
    struct FOUR22 has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOUR22, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOUR22>(arg0, 6, b"Four22", b"4:22", b"abababababa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_a_ae_a_2024_12_02_042204_6a699cf7ef.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOUR22>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOUR22>>(v1);
    }

    // decompiled from Move bytecode v6
}

