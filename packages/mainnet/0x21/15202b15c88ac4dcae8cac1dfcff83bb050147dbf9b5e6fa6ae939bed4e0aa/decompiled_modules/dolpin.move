module 0x2115202b15c88ac4dcae8cac1dfcff83bb050147dbf9b5e6fa6ae939bed4e0aa::dolpin {
    struct DOLPIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOLPIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOLPIN>(arg0, 6, b"DOLPIN", b"dolpin", x"24446f6c70696e2077696c6c206275696c6420405375694e6574776f726b20616e6420416c6f6e67207769746820636f6d6d756e697479200a0a4d616b6520746865204265737420746865204d656d6520436f696e206c61756e63682077697468204d4f564550554d500a0a4974206973207265616c2024444f4c50494e2074696d65", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_02_20_32_06_ac064ba03b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOLPIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOLPIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

