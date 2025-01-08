module 0xd72969ca5822dd4eedc196d07d5e6cfa2ef0283575d308763df249971c78be47::christ {
    struct CHRIST has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHRIST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHRIST>(arg0, 9, b"CHRIST", b"Jesus", b"X1000", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e2b184b2-07e0-4b85-98af-a7b07362d9c4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHRIST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHRIST>>(v1);
    }

    // decompiled from Move bytecode v6
}

