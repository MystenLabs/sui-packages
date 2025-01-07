module 0x40623722c38f86f0630b3b0a7fb8d567e9755ed049e9157c48f385b9e89a5222::bhogi {
    struct BHOGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BHOGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BHOGI>(arg0, 6, b"BHOGI", b"Bhogi", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BHOGI>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BHOGI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BHOGI>>(v1);
    }

    // decompiled from Move bytecode v6
}

