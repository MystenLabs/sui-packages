module 0xe7194fd262ad3f6b8df3adf4817eeda0f2a230092934afcc1c41013e83212d4d::xusd {
    struct XUSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: XUSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XUSD>(arg0, 8, b"XUSD", b"XUSD", b"this is xusd coin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img2.baidu.com/it/u=2249492919,1307050096&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=504")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XUSD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XUSD>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<XUSD>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<XUSD>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

