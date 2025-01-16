module 0x52dcf2f04c7a25eab391afc8d278f4984a3c29c3d057887b28bb0c607defe4c6::texas {
    struct TEXAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEXAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEXAS>(arg0, 6, b"Texas", b"Tejas Calvo", x"5465786173206973206e676d6920636f636b7375636b6572206e756d62657220312e204e65656420746f20636f6c6c6563742066756e6420666f72206869732068616972207472616e73706c616e74206f6e207475726b65792e0a4e656564206d6f7265206d6f6e657920736f727279202c20322e30", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737035117220.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEXAS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEXAS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

