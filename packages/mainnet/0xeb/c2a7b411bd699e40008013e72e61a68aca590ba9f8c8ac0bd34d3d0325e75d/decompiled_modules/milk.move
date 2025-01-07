module 0xebc2a7b411bd699e40008013e72e61a68aca590ba9f8c8ac0bd34d3d0325e75d::milk {
    struct MILK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MILK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MILK>(arg0, 6, b"MILK", b"Milk", b"Cats are liquid", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cats_dbe94903c1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MILK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MILK>>(v1);
    }

    // decompiled from Move bytecode v6
}

