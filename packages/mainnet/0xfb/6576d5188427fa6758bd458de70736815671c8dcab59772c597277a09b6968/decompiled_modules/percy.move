module 0xfb6576d5188427fa6758bd458de70736815671c8dcab59772c597277a09b6968::percy {
    struct PERCY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PERCY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PERCY>(arg0, 6, b"PERCY", b"Percy Verence", b"RIP KEKIUS MAXIMUS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7510_bf17b82cbd.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PERCY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PERCY>>(v1);
    }

    // decompiled from Move bytecode v6
}

