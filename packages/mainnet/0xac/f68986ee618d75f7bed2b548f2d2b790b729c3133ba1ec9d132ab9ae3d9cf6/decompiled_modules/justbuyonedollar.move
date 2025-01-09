module 0xacf68986ee618d75f7bed2b548f2d2b790b729c3133ba1ec9d132ab9ae3d9cf6::justbuyonedollar {
    struct JUSTBUYONEDOLLAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUSTBUYONEDOLLAR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<JUSTBUYONEDOLLAR>(arg0, 6, b"JUSTBUYONEDOLLAR", b"Just Buy $1 worth of this coin by SuiAI", b"The 'Just Buy $1 worth of this coin' agent encourages users to explore the world of cryptocurrency in a low-risk, approachable way. This agent provides simple suggestions and insights on emerging coins, inspiring users to make small, manageable investments. Perfect for beginners taking their first steps and for seasoned investors looking to diversify their portfolios with minimal commitment. Plus, everybody will get rich in this way!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Screenshot_2024_12_19_221237_135c35a583.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JUSTBUYONEDOLLAR>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUSTBUYONEDOLLAR>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

