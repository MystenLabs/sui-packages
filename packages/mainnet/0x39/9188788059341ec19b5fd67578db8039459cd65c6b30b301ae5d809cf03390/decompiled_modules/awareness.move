module 0x399188788059341ec19b5fd67578db8039459cd65c6b30b301ae5d809cf03390::awareness {
    struct AWARENESS has drop {
        dummy_field: bool,
    }

    fun init(arg0: AWARENESS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AWARENESS>(arg0, 6, b"Awareness", b"Meme Awareness", x"736b696c6c3a206d656d652061776172656e6573730a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Leonardo_Phoenix_Create_a_stylized_logo_featuring_the_slogan_M_3_1af73a7c3e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AWARENESS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AWARENESS>>(v1);
    }

    // decompiled from Move bytecode v6
}

