module 0xd926a44131a5a29a9f68c1d355a5a7c6d05d1479f534cab3c80b9806b561c427::meowbob {
    struct MEOWBOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEOWBOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEOWBOB>(arg0, 9, b"MEOWBOB", b"bob", b"A street cat name Bob", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/313011e1-42f6-4e40-95fc-46a63e8d7bd2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEOWBOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEOWBOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

