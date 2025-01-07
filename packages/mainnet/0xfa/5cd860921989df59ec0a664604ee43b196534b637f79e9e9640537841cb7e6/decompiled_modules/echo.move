module 0xfa5cd860921989df59ec0a664604ee43b196534b637f79e9e9640537841cb7e6::echo {
    struct ECHO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ECHO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ECHO>(arg0, 6, b"ECHO", b"ECHO the Seal", x"4563686f20746865205365616c206f6e205355490a0a4272696e67696e67207468652053554920436f6d6d756e69747920746f676574686572207769746820746865204543484f20696e2074686520486967682053656173200a0a4543484f0a0a4561726e2043525950544f20484f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_500_x_500_px_9cc13e9f78.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ECHO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ECHO>>(v1);
    }

    // decompiled from Move bytecode v6
}

