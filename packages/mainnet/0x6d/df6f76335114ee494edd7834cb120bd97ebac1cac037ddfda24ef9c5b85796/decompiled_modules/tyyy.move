module 0x6ddf6f76335114ee494edd7834cb120bd97ebac1cac037ddfda24ef9c5b85796::tyyy {
    struct TYYY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TYYY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TYYY>(arg0, 9, b"TYYY", b"Ty", b"Aaa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5b980f63-13f9-4354-ad88-9c499bc30718.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TYYY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TYYY>>(v1);
    }

    // decompiled from Move bytecode v6
}

