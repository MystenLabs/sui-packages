module 0x26ff95cfd30e78654d6f8f43ff611b0cca68bb80ada01033698c988f0621a49e::hdsui {
    struct HDSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HDSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HDSUI>(arg0, 6, b"HDsui", b"Hello dog in sui", b"I am  first dog on phone in sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000125813_2f961f4d6e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HDSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HDSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

