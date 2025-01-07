module 0xaf832a5596d91986caad575d76fd60b1118c30f3f0167c6c4b13f0b68dea833b::suipe {
    struct SUIPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPE>(arg0, 6, b"SUIPE", b"SUI PEPE", b"SUIPE - The First MEME ON SUI REACH 1B$ MarketCap", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PEPESUI_0e3c988113.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

