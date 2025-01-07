module 0xd761939762a4a21b40f53b4a4795c4f384e615600bfffb17b62b1e0841573ba::ghfjhg {
    struct GHFJHG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GHFJHG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GHFJHG>(arg0, 9, b"GHFJHG", b"ASDFA", b"FGHJ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/58d4b556-0ca8-4e9c-9750-d469836db885.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GHFJHG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GHFJHG>>(v1);
    }

    // decompiled from Move bytecode v6
}

