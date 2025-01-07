module 0xfde0181862a10aa28763d5c9dcde1418f192a476ef54aafaf31706657df0a577::happydoggy {
    struct HAPPYDOGGY has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<HAPPYDOGGY>, arg1: 0x2::coin::Coin<HAPPYDOGGY>) {
        0x2::coin::burn<HAPPYDOGGY>(arg0, arg1);
    }

    fun init(arg0: HAPPYDOGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<HAPPYDOGGY>(arg0, 6, b"HAPPYDOGGY", b"Happy Doggy", b"This is a happy dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://f4.bcbits.com/img/a4226911043_10.jpg"))), false, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAPPYDOGGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<HAPPYDOGGY>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HAPPYDOGGY>>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<HAPPYDOGGY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<HAPPYDOGGY>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

