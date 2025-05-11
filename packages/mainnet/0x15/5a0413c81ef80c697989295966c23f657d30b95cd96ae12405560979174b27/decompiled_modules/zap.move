module 0x155a0413c81ef80c697989295966c23f657d30b95cd96ae12405560979174b27::zap {
    struct ZAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZAP>(arg0, 6, b"ZAP", b"Zapzap", b"ZAPz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bafkreicq3jop2gyzwxdw6qddd5p665zzronrkahzl74cepeplrtvjq5b2m_c19551f3a9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZAP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZAP>>(v1);
    }

    // decompiled from Move bytecode v6
}

