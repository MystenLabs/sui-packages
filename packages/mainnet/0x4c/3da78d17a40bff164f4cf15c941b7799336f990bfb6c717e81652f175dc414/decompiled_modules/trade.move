module 0x4c3da78d17a40bff164f4cf15c941b7799336f990bfb6c717e81652f175dc414::trade {
    struct TRADE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRADE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TRADE>(arg0, 6, b"TRADE", b"Trade Bot", b"An artificial intelligence agent capable of defining the target price of each cryptocurrency using all the knowledge available online and using the most established tools. It uses the most consistent authors and traders in the world as a price definition method.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Leonardo_Anime_XL_Make_a_robot_operating_on_a_financial_graph_0_1_bb017856ca.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TRADE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRADE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

