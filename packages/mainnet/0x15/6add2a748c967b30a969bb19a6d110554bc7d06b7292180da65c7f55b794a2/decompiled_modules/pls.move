module 0x156add2a748c967b30a969bb19a6d110554bc7d06b7292180da65c7f55b794a2::pls {
    struct PLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLS>(arg0, 6, b"Pls", b"PLS", b"Pleasehelp", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732614401324.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PLS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

