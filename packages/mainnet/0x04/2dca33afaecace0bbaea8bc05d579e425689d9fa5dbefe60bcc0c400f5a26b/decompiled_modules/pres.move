module 0x42dca33afaecace0bbaea8bc05d579e425689d9fa5dbefe60bcc0c400f5a26b::pres {
    struct PRES has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRES>(arg0, 6, b"PRES", b"PEPE RESISTANCE", b"INTRODUCING \"PEPE RESISTANCE\" ON THE SUI NETWORK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_17_15_28_20_c0c1cb18d6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PRES>>(v1);
    }

    // decompiled from Move bytecode v6
}

