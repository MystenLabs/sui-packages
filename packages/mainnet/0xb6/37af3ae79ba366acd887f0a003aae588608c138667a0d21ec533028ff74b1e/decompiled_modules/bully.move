module 0xb637af3ae79ba366acd887f0a003aae588608c138667a0d21ec533028ff74b1e::bully {
    struct BULLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULLY>(arg0, 9, b"BULLY", b"BULLY", b"BULLY BULLS EYE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://res.cloudinary.com/ddjudhfru/image/upload/v1761153510/sui_tokens/gbwwwtqy9wwwjdhujavz.webp"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<BULLY>>(0x2::coin::mint<BULLY>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BULLY>>(v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BULLY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

