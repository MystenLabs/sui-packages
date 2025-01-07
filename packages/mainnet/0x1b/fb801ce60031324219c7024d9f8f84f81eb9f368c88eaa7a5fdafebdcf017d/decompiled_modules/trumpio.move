module 0x1bfb801ce60031324219c7024d9f8f84f81eb9f368c88eaa7a5fdafebdcf017d::trumpio {
    struct TRUMPIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPIO>(arg0, 6, b"Trumpio", b"Trump Mario", x"4120636f6d626f207468617420796f752063616e277420696d6167696e652e205472756d70206173204d6172696f2c20726561647920746f20706f77657220757020616e642074616b65206f766572205375692e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_1_5ef45b9518.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

