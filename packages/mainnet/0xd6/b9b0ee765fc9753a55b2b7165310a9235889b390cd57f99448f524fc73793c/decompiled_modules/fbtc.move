module 0xd6b9b0ee765fc9753a55b2b7165310a9235889b390cd57f99448f524fc73793c::fbtc {
    struct FBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: FBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FBTC>(arg0, 6, b"FBTC", b"Fomo bitcoin", b"A new digital currency in a new society Sui Fomo bitcoin New financial freedom, a new world is calling youWe will buy with you in large quantities and sell later  ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000040048_a0c31dd74e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FBTC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FBTC>>(v1);
    }

    // decompiled from Move bytecode v6
}

