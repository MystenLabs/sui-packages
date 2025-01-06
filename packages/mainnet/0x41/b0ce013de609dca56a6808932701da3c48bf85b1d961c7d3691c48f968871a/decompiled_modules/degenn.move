module 0x41b0ce013de609dca56a6808932701da3c48bf85b1d961c7d3691c48f968871a::degenn {
    struct DEGENN has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DEGENN>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<DEGENN>>(0x2::coin::mint<DEGENN>(arg0, arg2 * 1000000000, arg3), arg1);
    }

    fun init(arg0: DEGENN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEGENN>(arg0, 9, b"DEGENN", b"DEGENN", b"Next level super DEGENN a meme or cult for true believers.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1845046272777973769/t9Jgl4pO_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DEGENN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEGENN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEGENN>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

