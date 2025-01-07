module 0x96f076b7a214a0f5807fb97bfc58f7e69ec377d14f11c54dc7d6917f9e57e6d0::koto {
    struct KOTO has drop {
        dummy_field: bool,
    }

    struct Gomi has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<KOTO>,
    }

    fun init(arg0: KOTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOTO>(arg0, 0, b"KOTO", b"KOTO", b"The utility token of the Studio Mirai ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"data:image/png;base64,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"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KOTO>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        let v3 = Gomi{
            id           : 0x2::object::new(arg1),
            treasury_cap : v2,
        };
        0x2::transfer::freeze_object<Gomi>(v3);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KOTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

