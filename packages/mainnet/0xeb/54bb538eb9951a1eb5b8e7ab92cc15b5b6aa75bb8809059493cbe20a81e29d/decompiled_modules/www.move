module 0xeb54bb538eb9951a1eb5b8e7ab92cc15b5b6aa75bb8809059493cbe20a81e29d::www {
    struct WWW has drop {
        dummy_field: bool,
    }

    fun init(arg0: WWW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WWW>(arg0, 9, b"WWW", b"We", b"Nem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fcb9cc65-f995-409a-a229-680422f66651.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WWW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WWW>>(v1);
    }

    // decompiled from Move bytecode v6
}

