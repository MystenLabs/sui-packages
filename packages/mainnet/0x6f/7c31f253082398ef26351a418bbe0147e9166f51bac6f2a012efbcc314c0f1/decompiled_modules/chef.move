module 0x6f7c31f253082398ef26351a418bbe0147e9166f51bac6f2a012efbcc314c0f1::chef {
    struct CHEF has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHEF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHEF>(arg0, 6, b"Chef", b"Sui Chef", b"Meet Sui Chef: The culinary genius behind our Meme Coin ! Blending flavours and fun, Sui Chef serves up delicious gains on the Sui blockchain. JOIN THE FEAST!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2024_10_19_10_47_09_8f6c4be573.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHEF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHEF>>(v1);
    }

    // decompiled from Move bytecode v6
}

