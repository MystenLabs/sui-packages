module 0x8507633dbb7ec23e47b970ccd7bf0ef4ff34b1bca31294ea93341a53c38ed29d::tru24 {
    struct TRU24 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRU24, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRU24>(arg0, 6, b"TRU24", b"TrumpWon", b"The best Coin that strongly supports the next American president, we vote together for truth, justice and strength", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/517_L5y_Gyi7_L_36a7fd465d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRU24>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRU24>>(v1);
    }

    // decompiled from Move bytecode v6
}

