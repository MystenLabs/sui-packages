module 0x851bc8c311bdd7a6cb55ffa2527637811ad956df361c2aa36c8a81059a49be24::clawdean {
    struct CLAWDEAN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<CLAWDEAN>, arg1: 0x2::coin::Coin<CLAWDEAN>) {
        0x2::coin::burn<CLAWDEAN>(arg0, arg1);
    }

    fun init(arg0: CLAWDEAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLAWDEAN>(arg0, 6, b"ClawDean", b"ClawDean", b"ClawDean", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/2008779197448060928/c2eMnIAJ_normal.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CLAWDEAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLAWDEAN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<CLAWDEAN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<CLAWDEAN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

