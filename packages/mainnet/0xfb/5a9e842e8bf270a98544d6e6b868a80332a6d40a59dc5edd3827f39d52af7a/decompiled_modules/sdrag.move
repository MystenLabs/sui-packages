module 0xfb5a9e842e8bf270a98544d6e6b868a80332a6d40a59dc5edd3827f39d52af7a::sdrag {
    struct SDRAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDRAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDRAG>(arg0, 6, b"SDRAG", b"Sui Dragon", b"SuiDragon is a community-driven decentralized meme token with a dedicated team, pushing and developing behind the scenes to make this the biggest Grow coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000365_0edc72e9e0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDRAG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SDRAG>>(v1);
    }

    // decompiled from Move bytecode v6
}

