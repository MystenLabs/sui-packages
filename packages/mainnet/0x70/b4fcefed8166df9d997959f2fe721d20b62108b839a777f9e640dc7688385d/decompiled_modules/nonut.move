module 0x70b4fcefed8166df9d997959f2fe721d20b62108b839a777f9e640dc7688385d::nonut {
    struct NONUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: NONUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NONUT>(arg0, 6, b"NoNut", b"ANAPHYLAXIS", b"Anaphylaxis: The ultimate Peanut nightmare ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ana_8c76bfef95.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NONUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NONUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

