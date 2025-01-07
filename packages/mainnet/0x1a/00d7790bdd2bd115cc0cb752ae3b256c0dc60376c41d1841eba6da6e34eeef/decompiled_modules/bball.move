module 0x1a00d7790bdd2bd115cc0cb752ae3b256c0dc60376c41d1841eba6da6e34eeef::bball {
    struct BBALL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBALL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBALL>(arg0, 9, b"BBALL", b"Baseball", b"BBALL was created to pay tribute to Baseball players.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/77bf162b-e9df-4cb3-a5d6-6cf45cb9b186.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBALL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BBALL>>(v1);
    }

    // decompiled from Move bytecode v6
}

