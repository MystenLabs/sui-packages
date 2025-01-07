module 0x18660464909b47de720edfd41b67f788f7d2099408de0f400b8caf0feffc4d0c::lgbtq {
    struct LGBTQ has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<LGBTQ>, arg1: 0x2::coin::Coin<LGBTQ>) {
        0x2::coin::burn<LGBTQ>(arg0, arg1);
    }

    public entry fun custom_burn(arg0: &mut 0x2::coin::TreasuryCap<LGBTQ>, arg1: &mut 0x2::coin::Coin<LGBTQ>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<LGBTQ>(arg0, 0x2::coin::split<LGBTQ>(arg1, arg2, arg3));
    }

    fun init(arg0: LGBTQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LGBTQ>(arg0, 6, b"LGBTQ", b"LGBTQ", b"LGBTQ Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://pbs.twimg.com/profile_images/1531201487002550272/BMljxIwE_400x400.jpg"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LGBTQ>(&mut v2, 314000000000000000, @0xffed1e3a3b44c55d8a1300bf9ad7abb11825d45e66ab4bcadb5f7b5f4bce7d3a, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LGBTQ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LGBTQ>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

