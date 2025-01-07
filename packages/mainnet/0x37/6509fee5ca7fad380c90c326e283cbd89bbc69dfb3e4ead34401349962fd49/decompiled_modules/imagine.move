module 0x376509fee5ca7fad380c90c326e283cbd89bbc69dfb3e4ead34401349962fd49::imagine {
    struct IMAGINE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<IMAGINE>, arg1: 0x2::coin::Coin<IMAGINE>) {
        0x2::coin::burn<IMAGINE>(arg0, arg1);
    }

    fun init(arg0: IMAGINE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<IMAGINE>(arg0, 9, b"IMAGINE", b"Imagine We All Held", b"Imagine we all held. Just $IMAGINE that.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/4DFHSt7byviLNAjF8TQhxLfXHF1EBjzj8rGzA6tvTefU.png?size=xl&key=0c2787")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<IMAGINE>(&mut v3, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IMAGINE>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<IMAGINE>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<IMAGINE>>(v1, @0x89c5d4361f88132fe69cd6fd5085bff3ec262c71723b0fcd5220e4288f762663);
    }

    public fun migrate_currency_to_v2(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<IMAGINE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<IMAGINE>(arg0, arg1, arg2, arg3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<IMAGINE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<IMAGINE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

