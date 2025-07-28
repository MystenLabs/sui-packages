module 0xd938eca5b9dc7f453111303e1a1db4928fd73ba858e41c4376d5d5d70eb33a8a::ai {
    struct AI has drop {
        dummy_field: bool,
    }

    struct AiTokenCap has key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<AI>,
    }

    public entry fun mint(arg0: &mut AiTokenCap, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let (_, _, _, _) = 0x2::token::confirm_with_treasury_cap<AI>(&mut arg0.cap, 0x2::token::transfer<AI>(0x2::token::mint<AI>(&mut arg0.cap, arg1, arg2), 0x2::tx_context::sender(arg2), arg2), arg2);
    }

    public entry fun spend(arg0: 0x2::token::Token<AI>, arg1: &mut 0x2::token::TokenPolicy<AI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::token::value<AI>(&arg0) == arg2, 0);
        let (_, _, _, _) = 0x2::token::confirm_request_mut<AI>(arg1, 0x2::token::spend<AI>(arg0, arg3), arg3);
    }

    fun init(arg0: AI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AI>(arg0, 6, b"T", b"Ai", b"Ai coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://example.com/Ai.png")), arg1);
        let v2 = v0;
        let (v3, v4) = 0x2::token::new_policy<AI>(&v2, arg1);
        let v5 = v4;
        let v6 = v3;
        let v7 = AiTokenCap{
            id  : 0x2::object::new(arg1),
            cap : v2,
        };
        0x2::token::allow<AI>(&mut v6, &v5, 0x2::token::spend_action(), arg1);
        0x2::token::share_policy<AI>(v6);
        0x2::transfer::share_object<AiTokenCap>(v7);
        0x2::transfer::public_transfer<0x2::token::TokenPolicyCap<AI>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AI>>(v1);
    }

    public entry fun mint_and_transfer(arg0: &mut AiTokenCap, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let (_, _, _, _) = 0x2::token::confirm_with_treasury_cap<AI>(&mut arg0.cap, 0x2::token::transfer<AI>(0x2::token::mint<AI>(&mut arg0.cap, arg1, arg3), arg2, arg3), arg3);
    }

    // decompiled from Move bytecode v6
}

