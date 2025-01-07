module 0xa8af79aeb103648b984f37668e34511c32730ddcbd546bdd355ad5d3fddf8406::derp {
    struct DERP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DERP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DERP>(arg0, 2, b"DERP", b"Derp On Sui", b"Derp on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://iili.io/JRia2yl.png")), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<DERP>(&mut v2, 10000000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DERP>>(v2, v3);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DERP>>(v1);
    }

    // decompiled from Move bytecode v6
}

