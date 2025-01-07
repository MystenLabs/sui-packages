module 0x519c31eb499016c91e58c969cf24e092b65c6b84fe8c8c53154fc38b8a5d0850::suikey {
    struct SUIKEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKEY>(arg0, 6, b"SUIKEY", b"SUIKEY token", b"I am not monkey, am suikey", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1341728835804_pic_3fcf1f6996.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIKEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

