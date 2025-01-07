module 0x473bf5c52e76c5a9d224e247a5da7cefbeed4cb4a7ec82046bf9eceaac375aed::bube {
    struct BUBE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BUBE>, arg1: 0x2::coin::Coin<BUBE>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BUBE>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BUBE>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: BUBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<BUBE>(arg0, 6, b"bube", b"BUBBLES", b"In the BubbleVerse, tokens represent fragile, shimmering bubbles. Each bubble holds value, but can burst at any moment, releasing its value to the community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://res.cloudinary.com/dkpo6c3me/image/upload/v1728984952/bube_od6sln.png")), false, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUBE>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<BUBE>>(v1, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<BUBE>, arg1: 0x2::coin::Coin<BUBE>) : u64 {
        0x2::coin::burn<BUBE>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<BUBE>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<BUBE> {
        0x2::coin::mint<BUBE>(arg0, arg1, arg2)
    }

    public entry fun pull(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BUBE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<BUBE>(arg0, arg1, arg2, arg3);
    }

    public entry fun push(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BUBE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<BUBE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

