module 0x2c48ff9140802552a3a9a5381816d3b2e0245daef95ec60627938eb9a1b2c998::jack {
    struct JACK has drop {
        dummy_field: bool,
    }

    fun init(arg0: JACK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JACK>(arg0, 6, b"Jack", b"Jack.Buy.hold.dont.be.an.ass.be.JACK", b"Jack, the Meme Donkey on SUI, is excited to officially announce his candidacy for the 2024 United States presidential election.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_13_16_46_57_919d5524d8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JACK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JACK>>(v1);
    }

    // decompiled from Move bytecode v6
}

