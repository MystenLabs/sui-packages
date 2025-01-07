module 0xf3156b111f0837e42fbad9f3707e2a6f185995f3c1238d27060a8ecb4f1890ed::goose {
    struct GOOSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOOSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOOSE>(arg0, 6, b"Goose", b"GooseonSui", b"$Goose", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ib_Q_Shbv_R_400x400_1305cea679.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOOSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOOSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

