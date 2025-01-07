module 0x327840b4a4f6da8280854896a26134dd370aedfad2d78fca47afa029306a4691::wumpus {
    struct WUMPUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WUMPUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WUMPUS>(arg0, 6, b"WUMPUS", b"Discords Mascot", x"57756d7075732c20746865204f6666696369616c204d6173636f7420666f7220446973636f72642e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmb_Cbny5_Se_MT_6q8su_A4t_QNR_Sje7s_Fc8_MT_Uno3_X_Wfc9_GS_2_U_edd2ccce35.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WUMPUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WUMPUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

