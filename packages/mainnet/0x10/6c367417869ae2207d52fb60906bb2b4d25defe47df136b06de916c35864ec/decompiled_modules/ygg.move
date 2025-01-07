module 0x106c367417869ae2207d52fb60906bb2b4d25defe47df136b06de916c35864ec::ygg {
    struct YGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: YGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YGG>(arg0, 9, b"YGG", b"YGG", b"Yield Guild Games", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.google.com/imgres?q=YGG%20token&imgurl=https%3A%2F%2Fs2.coinmarketcap.com%2Fstatic%2Fimg%2Fcoins%2F200x200%2F10688.png&imgrefurl=https%3A%2F%2Fcoinmarketcap.com%2Fcurrencies%2Fyield-guild-games%2F&docid=C6z-OQYGkZtjCM&tbnid=s4styPdGmPjw_M&vet=12ahUKEwicuKbRveOKAxV-ja8BHVkWGRQQM3oECB0QAA..i&w=200&h=200&hcb=2&ved=2ahUKEwicuKbRveOKAxV-ja8BHVkWGRQQM3oECB0QAA")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<YGG>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YGG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YGG>>(v1);
    }

    // decompiled from Move bytecode v6
}

