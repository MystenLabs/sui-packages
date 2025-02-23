module 0xec704be7e6c0794a61de6f5ae8a1be4d5652765dff33c3c53d6b0bd15cb95a76::HAK {
    struct HAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAK>(arg0, 9, b"HAK", b"HAK", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://caposui.xyz/assets/img/nobgcapo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAK>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<HAK>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<HAK>>(0x2::coin::mint<HAK>(&mut v2, 1100000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

