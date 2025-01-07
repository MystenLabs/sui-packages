module 0x1b126f44f3c8d9dc18b2123e399ac0e20b59c4b5a28af46ad7218dcac2105db2::chef {
    struct CHEF has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHEF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHEF>(arg0, 6, b"Chef", b"Sui Chef", b"Meet Sui Chef: The culinary genius behind our Meme Coin ! Blending flavours and fun, Sui Chef serves up delicious gains on the Sui blockchain. JOIN THE FEAST", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2F2024_10_19_10_47_09_8f6c4be573.jpg&w=640&q=75"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHEF>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CHEF>(&mut v2, 10000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHEF>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

