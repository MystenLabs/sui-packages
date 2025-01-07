module 0xfe9dbd0131d4d2bc0696274c20a412b6847f3f38b11deaeb4f9579f1a4788b4b::wartocen {
    struct WARTOCEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WARTOCEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WARTOCEN>(arg0, 9, b"WARTOCEN", b"WAR", b"Token of WAR", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/57ebc341-fc80-416c-971e-4249014c94a3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WARTOCEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WARTOCEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

