module 0xf22bc14de50080fdc7fe9ae127f139fce3e82475190b3af7989e171ce1357a7d::texas {
    struct TEXAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEXAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEXAS>(arg0, 6, b"Texas", b"Texas Cocksucker", x"5465786173206973206e676d6920636f636b7375636b6572206e756d62657220312e0a4e65656420746f20636f6c6c6563742066756e6420666f72206869732068616972207472616e73706c616e74206f6e207475726b65792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737034496521.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEXAS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEXAS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

