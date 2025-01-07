module 0xad1185c28ed4a6b0a83edced800185e5ce8fc3cff6f802404b5268e5f2889587::elaise {
    struct ELAISE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELAISE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELAISE>(arg0, 6, b"ELAISE", b"ELAISE !", b"ELAISE TOKEN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7962_ca461af85f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELAISE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ELAISE>>(v1);
    }

    // decompiled from Move bytecode v6
}

