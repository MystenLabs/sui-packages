module 0xd8bea22daf55e75ed3c8b2ee4382cf9736dc640cba97372e7b845279fa131036::suni {
    struct SUNI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUNI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUNI>(arg0, 6, b"SUNI", b"SUI CEO dog", x"554e492069732074686520646f672066726f6d204576616e20746865205355492043454f0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/uni_2419e7e791.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUNI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUNI>>(v1);
    }

    // decompiled from Move bytecode v6
}

