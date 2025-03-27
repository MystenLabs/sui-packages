module 0x9601542ae016ea39540ce9be5fbb8437d36d6a2f8636cd201bf1651fcf12c7ce::vroom_sui {
    struct VROOM_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: VROOM_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VROOM_SUI>(arg0, 9, b"vSui", b"Vroom Staked Sui", b"vroom vroom", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/suilend_points.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VROOM_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VROOM_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

