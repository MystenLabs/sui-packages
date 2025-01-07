module 0xca35b2cd5cff1258fa816b66a35de8defc9cbe0446e0de54aaa097e396e86a04::smeow {
    struct SMEOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMEOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMEOW>(arg0, 6, b"SMEOW", b"SAD MEOW", b"SUI SAD MEOW :(", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/08a853b3ef964a92b6ca30034fb7bb32_bcc1fec63f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMEOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMEOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

