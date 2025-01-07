module 0xbe605a1b045b504ea63dae65d45745acdd1e5cea786d426166f09879b20f1b49::bober {
    struct BOBER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOBER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOBER>(arg0, 6, b"Bober", b"Bober Sui", b"Bbr, kurwa! Ja pierdol, jakie bydl! Bbr! Ej, kurwa, bbr! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bbober_0fd88b4c50.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOBER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOBER>>(v1);
    }

    // decompiled from Move bytecode v6
}

