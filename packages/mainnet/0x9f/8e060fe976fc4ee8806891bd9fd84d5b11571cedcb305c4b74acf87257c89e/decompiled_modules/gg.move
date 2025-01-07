module 0x9f8e060fe976fc4ee8806891bd9fd84d5b11571cedcb305c4b74acf87257c89e::gg {
    struct GG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GG>(arg0, 9, b"GG", b"GG", b"Good Game. Gem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://as2.ftcdn.net/v2/jpg/01/77/28/55/1000_F_177285569_UbNLMkzig06WQUKxnXdLxR0Q4QtS8V2S.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GG>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GG>>(v1);
    }

    // decompiled from Move bytecode v6
}

