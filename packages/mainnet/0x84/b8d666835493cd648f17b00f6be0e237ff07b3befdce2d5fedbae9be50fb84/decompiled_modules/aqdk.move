module 0x84b8d666835493cd648f17b00f6be0e237ff07b3befdce2d5fedbae9be50fb84::aqdk {
    struct AQDK has drop {
        dummy_field: bool,
    }

    fun init(arg0: AQDK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AQDK>(arg0, 6, b"AQDK", b"AquaDraconis", b"A mystical blue-scaled digital asset inspired by sea dragons. Features rapid transactions, eco-friendly protocols, and cross-chain compatibility. Join the Drakeling community and swim through the crypto seas with confidence.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2025_05_24_11_14_26_b009049742.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AQDK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AQDK>>(v1);
    }

    // decompiled from Move bytecode v6
}

