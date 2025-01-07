module 0x1cd442498fd64fb4bf907dd355e91dedce39f66578dc78ff82a0f6a9ab0858a8::trumb {
    struct TRUMB has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMB>(arg0, 6, b"TrumB", b" President Trump", b"Meme Trump for community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734924985960.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

