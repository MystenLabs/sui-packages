module 0x35c2c70cdce9f01dfc799d9acf11935e5741862b35dffc26dd45b85374987903::lucky {
    struct LUCKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUCKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUCKY>(arg0, 6, b"LUCKY", b"Lucky Chameleon", x"4c75636b79204368616d656c656f6e3a20546865206d656d65636f696e2074686174207472616e73666f726d73206c75636b20696e746f206c696d69746c65737320706f73736962696c69746965732120f09fa68ef09f928e2057697468206974732076696272616e7420636861726d20616e642061207468726976696e6720636f6d6d756e6974792c20244c55434b59206973206865726520746f2061646420612073706c617368206f6620636f6c6f7220746f20796f75722063727970746f206a6f75726e65792e20496e73706972656420627920746865206c75636b69657374206368616d656c656f6e20696e20746865206a756e676c652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732400318360.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LUCKY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUCKY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

