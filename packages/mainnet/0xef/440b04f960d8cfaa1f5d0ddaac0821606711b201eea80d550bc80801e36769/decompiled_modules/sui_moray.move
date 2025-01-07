module 0xef440b04f960d8cfaa1f5d0ddaac0821606711b201eea80d550bc80801e36769::sui_moray {
    struct SUI_MORAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI_MORAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_MORAY>(arg0, 9, b"SUI MORAY", b"SUI MORAY", b"https://t.me/suimoraymovepump http://suimoray.xyz/ https://x.com/suimoray", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUI_MORAY>(&mut v2, 23232333000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI_MORAY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUI_MORAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

