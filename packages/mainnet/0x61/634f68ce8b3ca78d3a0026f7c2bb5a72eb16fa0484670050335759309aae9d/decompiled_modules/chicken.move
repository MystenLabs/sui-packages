module 0x61634f68ce8b3ca78d3a0026f7c2bb5a72eb16fa0484670050335759309aae9d::chicken {
    struct CHICKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHICKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHICKEN>(arg0, 6, b"CHICKEN", b"CHICKENSUI", x"41726520796f752072656164793f0a436869636b656e206f6e20535549", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7lf_YX_3b_X_400x400_d84fc50354.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHICKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHICKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

