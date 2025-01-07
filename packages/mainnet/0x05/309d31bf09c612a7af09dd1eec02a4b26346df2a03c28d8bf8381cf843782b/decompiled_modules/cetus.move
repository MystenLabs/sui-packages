module 0x5309d31bf09c612a7af09dd1eec02a4b26346df2a03c28d8bf8381cf843782b::cetus {
    struct CETUS has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<CETUS>, arg1: 0x2::coin::Coin<CETUS>) {
        0x2::coin::burn<CETUS>(arg0, arg1);
    }

    public entry fun custom_burn(arg0: &mut 0x2::coin::TreasuryCap<CETUS>, arg1: &mut 0x2::coin::Coin<CETUS>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<CETUS>(arg0, 0x2::coin::split<CETUS>(arg1, arg2, arg3));
    }

    fun init(arg0: CETUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CETUS>(arg0, 6, b"CETUS", b"CETUS", b"CETUS Meme on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://pbs.twimg.com/profile_images/1610882080841543680/DT_n5wDa_400x400.png"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CETUS>(&mut v2, 314000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CETUS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CETUS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

