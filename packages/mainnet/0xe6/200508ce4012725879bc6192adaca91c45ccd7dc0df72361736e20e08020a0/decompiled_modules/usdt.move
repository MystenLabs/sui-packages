module 0xe6200508ce4012725879bc6192adaca91c45ccd7dc0df72361736e20e08020a0::usdt {
    struct USDT has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<USDT>, arg1: 0x2::coin::Coin<USDT>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<USDT>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<USDT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<USDT>>(0x2::coin::mint<USDT>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: USDT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<USDT>(arg0, 6, b"USDT", b"USDT", x"5553445420e280942054657468657220737461626c65636f696e206f6e205375692e2050656767656420313a3120746f205553442e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://xvestor.ru/api/image/7d626264-af37-45fd-b052-5eb5b256f79b.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USDT>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCap<USDT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<USDT>>(v0);
    }

    // decompiled from Move bytecode v6
}

