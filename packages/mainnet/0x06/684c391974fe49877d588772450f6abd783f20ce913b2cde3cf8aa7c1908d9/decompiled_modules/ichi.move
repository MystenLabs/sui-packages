module 0x6684c391974fe49877d588772450f6abd783f20ce913b2cde3cf8aa7c1908d9::ichi {
    struct ICHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ICHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ICHI>(arg0, 9, b"ICHI", b"JIRACHI", b"Linktr: https://linktr.ee/jirachionsui - TG:https://t.me/JirachionSui -Website: https://www.jirachisui.online - X: https://x.com/jirachisui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.jirachisui.online/images/logo.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ICHI>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ICHI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ICHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

