module 0xfdc2c1e7b17546bf175eb3ff751865ef38642849e85a0f7286f8a8f7eae040af::ss {
    struct SS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SS>(arg0, 6, b"SS", b"Suicide Sui", b"Join the suicide squad and get a chance to get wl for the upcoming NFT collection. Have a nice time in the community until the nft collection is released", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ADSADAD_57713917bb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SS>>(v1);
    }

    // decompiled from Move bytecode v6
}

