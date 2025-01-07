module 0xdf37cbe2234b5d68d1d5e33511a60b9934a5b5fdd284decf20cf21fcb3e1712::lp_token {
    struct LP_TOKEN has drop {
        dummy_field: bool,
    }

    struct InitEvent has copy, drop {
        cap_id: 0x2::object::ID,
        metadata_id: 0x2::object::ID,
    }

    fun init(arg0: LP_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LP_TOKEN>(arg0, 9, b"afSUI-SUI vaultLP Cetus", b"afSUI-SUI Cetus Vault LP Token", b"Cetus Vault LP Token, afSUI-SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://j5w37hib4ojxo6bymogsbg5r5qkkdhuvfprizrw4kxakm3jxz24q.arweave.net/T22_nQHjk3d4OGONIJux7BShnpUr4ozG3FXApm03zrk")), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LP_TOKEN>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LP_TOKEN>>(v3, 0x2::tx_context::sender(arg1));
        let v4 = InitEvent{
            cap_id      : 0x2::object::id<0x2::coin::TreasuryCap<LP_TOKEN>>(&v3),
            metadata_id : 0x2::object::id<0x2::coin::CoinMetadata<LP_TOKEN>>(&v2),
        };
        0x2::event::emit<InitEvent>(v4);
    }

    // decompiled from Move bytecode v6
}

