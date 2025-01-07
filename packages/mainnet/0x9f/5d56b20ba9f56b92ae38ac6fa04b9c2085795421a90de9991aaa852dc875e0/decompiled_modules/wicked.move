module 0x9f5d56b20ba9f56b92ae38ac6fa04b9c2085795421a90de9991aaa852dc875e0::wicked {
    struct WICKED has drop {
        dummy_field: bool,
    }

    fun init(arg0: WICKED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WICKED>(arg0, 6, b"WICKED", b"Wicked Sui", b"A MEME DRIVEN CULT ON SUI ! A MEME DRIVEN CULT ON SUI !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731966956940.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WICKED>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WICKED>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

