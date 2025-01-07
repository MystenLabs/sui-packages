module 0x64e35989ac86301a9c5ce5acb837fa992eca27ac6714543cf0f3ec0be1fc90f4::dmn {
    struct DMN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DMN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DMN>(arg0, 9, b"DMN", b"DAMON", b"damonz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0c35f83b-76ae-4990-8f59-0c38df43832a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DMN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DMN>>(v1);
    }

    // decompiled from Move bytecode v6
}

