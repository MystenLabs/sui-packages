module 0x408ee2c4772c4ef06897a19487212faaa32a26efaa38778fe5d4d1ed86cbd131::great {
    struct GREAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GREAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GREAT>(arg0, 6, b"GREAT", b"testing", b"yhhh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_b4f978c8e4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GREAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GREAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

