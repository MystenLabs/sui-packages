module 0x356da6e5ccdad5e5cea08ffd899e038c6494470cc0801323aa37ee8691a5a9ed::cinos {
    struct CINOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CINOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CINOS>(arg0, 6, b"CINOS", b"Sui Cinos", b"Cinos speed, Sonic a gains! Cinos  is launching exclusively on sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000011162_9b9c248881.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CINOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CINOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

