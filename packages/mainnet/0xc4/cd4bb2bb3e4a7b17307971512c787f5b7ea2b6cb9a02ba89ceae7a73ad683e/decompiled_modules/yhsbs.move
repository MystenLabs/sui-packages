module 0xc4cd4bb2bb3e4a7b17307971512c787f5b7ea2b6cb9a02ba89ceae7a73ad683e::yhsbs {
    struct YHSBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: YHSBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YHSBS>(arg0, 9, b"YHSBS", b"hendn", b"jdnd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ca9f37c8-0b9e-46f9-832f-8d0a48af1b14.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YHSBS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YHSBS>>(v1);
    }

    // decompiled from Move bytecode v6
}

