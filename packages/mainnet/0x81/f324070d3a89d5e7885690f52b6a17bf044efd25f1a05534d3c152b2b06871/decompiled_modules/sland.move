module 0x81f324070d3a89d5e7885690f52b6a17bf044efd25f1a05534d3c152b2b06871::sland {
    struct SLAND has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLAND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLAND>(arg0, 9, b"SLAND", b"SuiLand", b"SuiLand is a decentralized token on the Sui blockchain, blending the power of wolves with digital land ownership. It offers users the freedom to explore, stake, and trade in a dynamic, narrative-driven ecosystem, embodying strength, agility, and innovation in the digital frontier.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1842157971641409536/JgiKDeHB.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SLAND>(&mut v2, 3000000010000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLAND>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLAND>>(v1);
    }

    // decompiled from Move bytecode v6
}

