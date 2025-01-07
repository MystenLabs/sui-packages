module 0xd1ad22f838cd6d1215d8568d4d2cbace368a48af26e9d80f0b5539ed7b9e87c2::sity {
    struct SITY has drop {
        dummy_field: bool,
    }

    public fun create(arg0: &mut 0x2::coin::TreasuryCap<SITY>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::token::Token<SITY> {
        0x2::token::mint<SITY>(arg0, arg1, arg2)
    }

    fun init(arg0: SITY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SITY>(arg0, 3, b"SITY", b"SITY", b"Native token of @SuiCityP2E", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafybeig4236djyafwvxzkb3km7o3xa25lsfg55bxvyrwbxyemlzjnjjpsi.ipfs.w3s.link/sity%20logo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SITY>>(v1);
        let (v3, v4) = 0x2::token::new_policy<SITY>(&v2, arg1);
        0x2::token::share_policy<SITY>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SITY>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::token::TokenPolicyCap<SITY>>(v4, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

