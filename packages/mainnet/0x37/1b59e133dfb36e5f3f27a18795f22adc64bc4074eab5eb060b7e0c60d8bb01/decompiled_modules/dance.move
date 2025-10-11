module 0x371b59e133dfb36e5f3f27a18795f22adc64bc4074eab5eb060b7e0c60d8bb01::dance {
    struct DANCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DANCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DANCE>(arg0, 9, b"DANCE", b"Suider Dance", b"Dance with Suider~", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://media.tenor.com/BOeRoWwpveQAAAAM/yes.gif")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DANCE>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DANCE>>(v2, @0x51b85cc1c6d6ebc369f98682dafa137d3f967b7145581684299dc85a9e1ac3a);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DANCE>>(v1);
    }

    // decompiled from Move bytecode v6
}

