module 0xdc5ed5bc87c2d983c9cf938eebcac3fd9233fb072fd4d310841df014baadbb09::tuma {
    struct TUMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUMA>(arg0, 9, b"TUMA", b"Tusnami", x"496e74726f647563696e6720205473756e616d69202854554d4129203a20746865206d656d6520636f696e206d616b696e6720776176657320696e20746865205375692065636f73797374656d212054726164652c207374616b652c20616e6420637265617465206d656d6573206566666f72746c6573736c792076696120576176652057616c6c65742e204a6f696e206f75722076696272616e7420636f6d6d756e69747920616e642072696465207468652077617665206f662066756e20616e642072657761726473e280946c6574e2809973206d616b6520612073706c61736820746f67657468657221", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ff5b124c-1271-4578-abf2-eaa702d3b9df.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TUMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

