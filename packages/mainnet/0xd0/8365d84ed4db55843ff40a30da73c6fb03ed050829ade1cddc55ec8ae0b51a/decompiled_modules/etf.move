module 0xd08365d84ed4db55843ff40a30da73c6fb03ed050829ade1cddc55ec8ae0b51a::etf {
    struct ETF has drop {
        dummy_field: bool,
    }

    fun init(arg0: ETF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ETF>(arg0, 6, b"ETF", b"Sui ETF", b"Every Trades Fucked", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/redbull_539462f5e7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ETF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ETF>>(v1);
    }

    // decompiled from Move bytecode v6
}

