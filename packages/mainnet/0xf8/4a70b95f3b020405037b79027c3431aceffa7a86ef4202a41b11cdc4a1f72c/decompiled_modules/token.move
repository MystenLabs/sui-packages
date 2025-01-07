module 0xf84a70b95f3b020405037b79027c3431aceffa7a86ef4202a41b11cdc4a1f72c::token {
    struct TOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKEN>(arg0, 9, b"Senet", b"SENET", b"The offical token of senet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://firebasestorage.googleapis.com/v0/b/colorapps-87bc6.appspot.com/o/senet%3Asui.png?alt=media&token=aa0d4c52-fbc2-411d-8d71-14a0cf148464")), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<TOKEN>(&mut v2, 1000000000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKEN>>(v2, v3);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKEN>>(v1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<TOKEN>(arg0) + arg1 <= 1000000000000000000, 1);
        0x2::coin::mint_and_transfer<TOKEN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

