module 0xfb140e615ee8420d502943681c07df14f9fdbd53aba5b76b646e9b98aac218fd::bardo {
    struct BARDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BARDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BARDO>(arg0, 6, b"BARDO", b"Sui Bardo", b"Bardo is a bear that loves to be treated like the best. You either treat him with respect or you just dont exist. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_2024_07_14_T210854_406_2045ac85ca.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BARDO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BARDO>>(v1);
    }

    // decompiled from Move bytecode v6
}

