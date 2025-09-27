module 0x73b878f6dc9dfbf79813420ef30fd75bf5fdf2d08d6e9affdcbd979b158ac99f::skynet {
    struct SKYNET has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKYNET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKYNET>(arg0, 9, b"SKYNET", b"SKYNET", b"Ok ok, so yea we are really building SkyNet with #Sui stack.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://res.cloudinary.com/ddjudhfru/image/upload/v1758971900/sui_tokens/oj0coa1j7kf9qfbwutuv.webp"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SKYNET>>(0x2::coin::mint<SKYNET>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SKYNET>>(v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SKYNET>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

