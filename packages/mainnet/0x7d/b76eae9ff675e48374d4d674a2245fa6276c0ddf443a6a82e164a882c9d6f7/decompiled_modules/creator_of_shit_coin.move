module 0x7db76eae9ff675e48374d4d674a2245fa6276c0ddf443a6a82e164a882c9d6f7::creator_of_shit_coin {
    struct CREATOR_OF_SHIT_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CREATOR_OF_SHIT_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CREATOR_OF_SHIT_COIN>(arg0, 9, b"I'm the creator of shit coin", b"CREATOR OF SHIT COIN", b"MAKE SHIT COINS GREATE AGAIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://coincentral.com/wp-content/uploads/2018/02/shitcoin.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CREATOR_OF_SHIT_COIN>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CREATOR_OF_SHIT_COIN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CREATOR_OF_SHIT_COIN>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

