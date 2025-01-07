module 0x8126ce1f1fd2a03b43f174bf29351ab2ec257c3cdb45e542fb3cbe4482b0e4e7::dcc {
    struct DCC has drop {
        dummy_field: bool,
    }

    fun create_currency<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<T0> {
        let (v0, v1) = 0x2::coin::create_currency<T0>(arg0, 9, b"DDC", b"Daniel Dupuis Coin", b"The Daniel Dupuis Coin (DDC) is a cryptocurrency designed to honor and celebrate the contributions of Professor Daniel Dupuis to the world of blockchain education and innovation. DDC is not just a token; it represents a community-driven initiative to promote learning, innovation, and practical application of blockchain technology!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::string::to_ascii(0x1::string::utf8(b"https://i.imgur.com/h9OYUZy.jpeg")))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(v1);
        v0
    }

    fun init(arg0: DCC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = create_currency<DCC>(arg0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DCC>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DCC>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DCC>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

