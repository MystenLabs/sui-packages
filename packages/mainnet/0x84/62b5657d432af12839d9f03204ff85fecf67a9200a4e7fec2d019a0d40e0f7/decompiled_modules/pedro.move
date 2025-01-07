module 0x8462b5657d432af12839d9f03204ff85fecf67a9200a4e7fec2d019a0d40e0f7::pedro {
    struct PEDRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEDRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEDRO>(arg0, 6, b"PEDRO", b"Pedro The Sui Bull", b"Pedro is a bull who lives in the Sui network, he loves nature and tranquility. He is an expert in finance and making your money grow.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pedrohead_6e050f0579.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEDRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEDRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

