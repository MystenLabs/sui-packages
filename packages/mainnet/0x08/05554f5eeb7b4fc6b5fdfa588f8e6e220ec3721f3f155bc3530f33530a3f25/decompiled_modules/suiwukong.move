module 0x805554f5eeb7b4fc6b5fdfa588f8e6e220ec3721f3f155bc3530f33530a3f25::suiwukong {
    struct SUIWUKONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWUKONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWUKONG>(arg0, 6, b"SuiWuKong", b"Sui WuKong", b"From the East to the West, we stand as one, a multi-culture coin has just begun. Join the SuiWukong community now on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/172707944358977_P30312494_a3da894981.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWUKONG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIWUKONG>>(v1);
    }

    // decompiled from Move bytecode v6
}

