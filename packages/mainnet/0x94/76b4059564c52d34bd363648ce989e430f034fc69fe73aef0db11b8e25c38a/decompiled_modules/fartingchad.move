module 0x9476b4059564c52d34bd363648ce989e430f034fc69fe73aef0db11b8e25c38a::fartingchad {
    struct FARTINGCHAD has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<FARTINGCHAD>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<FARTINGCHAD>>(0x2::coin::mint<FARTINGCHAD>(arg0, arg2 * 1000000000, arg3), arg1);
    }

    fun init(arg0: FARTINGCHAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FARTINGCHAD>(arg0, 9, b"FTCHAD", b"FARTINGCHAD", b"Just a chad thats farting aka (releasing hot air)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1715203662711267328/6KV6ZoCn_400x400.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FARTINGCHAD>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FARTINGCHAD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FARTINGCHAD>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

