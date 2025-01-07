module 0x9bf7110f09fb31718357e761bbfb1f82ceba7dd1f6ea2c4fa7bd777dbfcad0c1::witcher {
    struct WITCHER has drop {
        dummy_field: bool,
    }

    fun init(arg0: WITCHER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<WITCHER>(arg0, 6, b"WITCHER", b"MAKE SUAI AND THIS MEME THE WINNER OF THE CYCLE (MSA TMT WOTC)", b"JUST THE BEST AI AGENT MEME", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/4560500047_751a1680e5_z_eec9df2dfb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WITCHER>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WITCHER>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

