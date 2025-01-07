module 0xf7b492ce11e1d90fb056fea3dcf6e585a68448018474b88a2695bd355633b632::wabisabi {
    struct WABISABI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WABISABI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WABISABI>(arg0, 6, b"WABISABI", b"Wabi Sabi by Elon", b"Wabi Sabi by Elon (on X)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732139278739.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WABISABI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WABISABI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

