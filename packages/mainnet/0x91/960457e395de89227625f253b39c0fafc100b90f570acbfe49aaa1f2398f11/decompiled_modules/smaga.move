module 0x91960457e395de89227625f253b39c0fafc100b90f570acbfe49aaa1f2398f11::smaga {
    struct SMAGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMAGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMAGA>(arg0, 6, b"SMaga", b"Maga", b"Maga in Sui, go to the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000065956_2bf1b72791.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMAGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMAGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

