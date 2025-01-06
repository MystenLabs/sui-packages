module 0x40868a958524f2fee6ba6ac46e25689ca81429d37e112178227c0fd853806c2e::shaer {
    struct SHAER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHAER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHAER>(arg0, 9, b"SHAER", b"SHEEP", b"SHEEP CUTE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d945fff3-c0af-4a00-acf3-821a72d6ef8e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHAER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHAER>>(v1);
    }

    // decompiled from Move bytecode v6
}

