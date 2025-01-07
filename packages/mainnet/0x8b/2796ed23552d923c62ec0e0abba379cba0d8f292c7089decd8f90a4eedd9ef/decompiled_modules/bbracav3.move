module 0x8b2796ed23552d923c62ec0e0abba379cba0d8f292c7089decd8f90a4eedd9ef::bbracav3 {
    struct BBRACAV3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBRACAV3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBRACAV3>(arg0, 9, b"BBRACAV3", b"Babyracav3", x"4261627920726163612076332069732061207369676e69666963616e74207374657020666f727761726420696e20746865206a6f75726e657920746f20776562203320636f6d62696e696e672041692c2055534d20616e64204d65746176657273652077696c6c2062652061207374657070696e672073746f6e6520746f20656c657661746520526163612056332e20436f6d652077697468206d6520f09f9a80f09f9a80f09f9a80", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2f7376c8-1202-4601-8fb5-0b2d3e93cc89-BABYRACA.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBRACAV3>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BBRACAV3>>(v1);
    }

    // decompiled from Move bytecode v6
}

