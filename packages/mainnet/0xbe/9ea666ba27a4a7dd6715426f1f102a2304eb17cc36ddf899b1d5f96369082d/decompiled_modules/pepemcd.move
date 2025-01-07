module 0xbe9ea666ba27a4a7dd6715426f1f102a2304eb17cc36ddf899b1d5f96369082d::pepemcd {
    struct PEPEMCD has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPEMCD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPEMCD>(arg0, 6, b"PEPEMCD", b"MCD PEPE", b"Pepe after memecoins", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sticker_b4e1a2ec71.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPEMCD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPEMCD>>(v1);
    }

    // decompiled from Move bytecode v6
}

