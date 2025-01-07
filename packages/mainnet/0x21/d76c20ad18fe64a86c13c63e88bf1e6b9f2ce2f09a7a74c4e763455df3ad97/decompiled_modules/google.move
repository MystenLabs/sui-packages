module 0x21d76c20ad18fe64a86c13c63e88bf1e6b9f2ce2f09a7a74c4e763455df3ad97::google {
    struct GOOGLE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<GOOGLE>, arg1: 0x2::coin::Coin<GOOGLE>) {
        0x2::coin::burn<GOOGLE>(arg0, arg1);
    }

    public entry fun custom_burn(arg0: &mut 0x2::coin::TreasuryCap<GOOGLE>, arg1: &mut 0x2::coin::Coin<GOOGLE>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<GOOGLE>(arg0, 0x2::coin::split<GOOGLE>(arg1, arg2, arg3));
    }

    fun init(arg0: GOOGLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOOGLE>(arg0, 6, b"GOOGLE", b"GOOGLE", b"GOOGLE Meme on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Google_%22G%22_Logo.svg/706px-Google_%22G%22_Logo.svg.png"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GOOGLE>(&mut v2, 314000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOOGLE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOOGLE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

