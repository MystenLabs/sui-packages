module 0xbfd317cb34389e646cc4a470ec1fe4082176ffa5da99a6940cc4c1ac531a7467::lgbt {
    struct LGBT has drop {
        dummy_field: bool,
    }

    fun init(arg0: LGBT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LGBT>(arg0, 9, b"LGBT", b"PUTOS", b"Comunidadgay", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAR4AAACwCAMAAADudvHOAAAAM1BMVEXlAAB3AIj/jQD/7gACgSEATP/3agD/kAD/igD/rgD/8gD57AACgwABXs0ASv8yOd17AIElIUCVAAABL0lEQVR4nO3Qt2ECAAAEsSfagAn7T+sNrqGVRtAGAAAAAAAAAPC9K2E/hB0JepKepCfpSXqSnqQn6Ul6kp6kJ+lJepKepCfpSXqSnqQn6Ul6kp6kJ+lJetJ+CbsRdifsRNCT9CQ9SU/Sk/QkPUlP0pP0JD1JT9KT9CQ9SU/Sk/QkPUlP0pP0JD1JT9KT9KQ9CDsT9CQ9SU/Sk/QkPUlP0pP0JD1JT9KT9CQ9SU/Sk/QkPUlP0pP0JD1JT9KT9CQ9SU/aH2FPwl6EXQh6kp6kJ+lJepKepCfpSXqSnqQn6Ul6kp6kJ+lJepKepCfpSXqSnqQn6Ul6kp60N2Efwg4EPUlP0pP0JD1JT9KT9CQ9SU/Sk/QkPUlP0pP0JD1JT9KT9CQ9SU/Sk/QkPUlP0pP+AVBYTx1VbfZ4AAAAAElFTkSuQmCC")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LGBT>(&mut v2, 2999999999000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LGBT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LGBT>>(v1);
    }

    // decompiled from Move bytecode v6
}

