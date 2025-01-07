module 0x78ee47f03c52702c5d573e13db9c2c8232326f087b04dcc42d6ce9a2b2076904::luna {
    struct LUNA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUNA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUNA>(arg0, 6, b"LUNA", b"Ludicrous Unraveled Nonsense A", b"In the midst of a wild acid trip, Luna the Alpaca-Ludicrous Unraveled Nonsense Alpaca-laughed through a surreal, swirling world. As the trip unfolded, Lunas humor seemed to mock the people who had lost their money due to Do Kwons blunders, embodying their misguided faith and the folly of their investment. Each gleeful leap and twirl became a symbol of their freedom from the financial wreckage, turning their loss into a cosmic joke. Amidst the laughter and vibrant colors, Luna represented both the absurdity of their choices and the liberation from their misguided dreams.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_06_19_01_00_0463d4cd17.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUNA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUNA>>(v1);
    }

    // decompiled from Move bytecode v6
}

