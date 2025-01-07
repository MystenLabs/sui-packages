module 0xe18afb829c26e339bf4148d8469e42eee9505a3b3111a80572ee370680938979::suiendit {
    struct SUIENDIT has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIENDIT>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIENDIT>>(0x2::coin::mint<SUIENDIT>(arg0, arg2 * 1000000000, arg3), arg1);
    }

    fun init(arg0: SUIENDIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIENDIT>(arg0, 9, b"SUNDIT", b"Suiendit", b"Lets just SEND it, similar to sol SUNDIT is prepare for the moon, second AI chain!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1769610998477107200/SPX7o_8U_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIENDIT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIENDIT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIENDIT>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

