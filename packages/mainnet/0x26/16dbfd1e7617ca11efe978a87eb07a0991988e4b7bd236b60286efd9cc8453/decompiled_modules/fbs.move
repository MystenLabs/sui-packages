module 0x2616dbfd1e7617ca11efe978a87eb07a0991988e4b7bd236b60286efd9cc8453::fbs {
    struct FBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FBS>(arg0, 6, b"FBS", b"FANGBATSUI", b"Fangbat has many years of experience investing in cryptocurrencies. He has experienced the market's dizzying price increases and decreases and has learned many lessons. When he heard about Suinetwork, Fangbat was very interested and decided to allocate part of his portfolio to this coin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3_cf8a937ef7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FBS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FBS>>(v1);
    }

    // decompiled from Move bytecode v6
}

