module 0xd7b8f60782cef81f3d98ed11f4186e060f70ab1ca5495e0028b74720559b55ab::wyty {
    struct WYTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WYTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WYTY>(arg0, 9, b"WYTY", b"Waky tabky", x"5768656e206120706c616e6520616c6c2063696761726574746520776f6ee280997420646f2074686520747269636b206772616220796f757273656c662061204a20616e6420736d6f6b652074686174207761636b7920746162616b79", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b3f3eb03-c22e-4cce-ae3f-c75e57b4035b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WYTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WYTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

