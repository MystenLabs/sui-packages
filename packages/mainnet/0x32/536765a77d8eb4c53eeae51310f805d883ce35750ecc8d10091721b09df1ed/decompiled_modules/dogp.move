module 0x32536765a77d8eb4c53eeae51310f805d883ce35750ecc8d10091721b09df1ed::dogp {
    struct DOGP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGP>(arg0, 6, b"DOGP", b"Dogphin", b"Dogphin is Sui's favorite pet. He surfs the waves of the chart with the intelligence of a dolphin and will always stay with his community like a faithful dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000064004_50300d48f1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGP>>(v1);
    }

    // decompiled from Move bytecode v6
}

