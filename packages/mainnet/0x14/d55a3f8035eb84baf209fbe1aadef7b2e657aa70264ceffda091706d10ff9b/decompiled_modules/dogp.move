module 0x14d55a3f8035eb84baf209fbe1aadef7b2e657aa70264ceffda091706d10ff9b::dogp {
    struct DOGP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGP>(arg0, 6, b"DOGP", b"Dogphin", b"Dogphin is Sui's favorite pet. He surfs the waves of the chart with the intelligence of a dolphin and will always stay with his community like a faithful dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000064004_e5cb9a52b2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGP>>(v1);
    }

    // decompiled from Move bytecode v6
}

