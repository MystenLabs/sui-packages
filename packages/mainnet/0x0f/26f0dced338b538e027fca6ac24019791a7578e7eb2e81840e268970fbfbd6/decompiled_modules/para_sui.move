module 0xf26f0dced338b538e027fca6ac24019791a7578e7eb2e81840e268970fbfbd6::para_sui {
    struct PARA_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PARA_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PARA_SUI>(arg0, 9, b"ParaSui", b"Parabuilders Staked SUI", b"Stake SUI to fuel content creators - Powered by ParaBuilders.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://media-hosting.imagekit.io/55804c4ad92d4566/2b5062f0-6845-4473-a1c6-475eaa02b4e6.png?Expires=1838829163&Key-Pair-Id=K2ZIVPTIP2VGHC&Signature=FTiAg6ciOujjL1ZyXolQ-hooGSz~4091L49FX5cfsV0xoWzzQrIM~nD6fvntF520Z5GlAQ3Nngski6pnFqv07gAQ74mpSRIYul1-aZsf3Qxkx~GxApbMtjnkN7wBcK3WiXZ~tVnCnmKY16FFWRn750YRurzKsDfNNHpvbMt8mEEj8on1Bamu5V2hf1tHRDww-1iPmes0gUOc9ZEss4OZm-ScEpaEfQqkmxloYMaS0DcvgXnG6DTmvUvDMKnPYCPbH2EGpOcS~mT8V2PJiKYk6AfBoA721D6x7ThnhlU9RKWLdg--2qJ5NtFg7sOLDC4vU4BHOFqweBWorTvH0hc4Lg__")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PARA_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PARA_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

