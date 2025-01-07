module 0x25572d79387b2ccbacf2a2650d472a1f07946af3af9699432212fc204439d49e::croak {
    struct CROAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CROAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CROAK>(arg0, 9, b"CROAK", b"CroakCoin on SUI", b"This image showcases a digital token featuring a golden coin design with a frog wearing a formal business suit and red tie. The coin is adorned with the word \"CROAK\" at the top, symbolizing the frog's association, perhaps a play on its sound. The coin is surrounded by a laurel wreath, a traditional symbol of success and prestige, and small dollar signs, emphasizing wealth or value. The token is displayed in a futuristic setting, with glowing blue lights and digital circuitry, implying a connection to blockchain technology or cryptocurrency. The overall aesthetic conveys innovation, value, and a playful, yet professional, approach to digital finance.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://imgur.com/a/RZiEshK")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CROAK>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CROAK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CROAK>>(v1);
    }

    // decompiled from Move bytecode v6
}

