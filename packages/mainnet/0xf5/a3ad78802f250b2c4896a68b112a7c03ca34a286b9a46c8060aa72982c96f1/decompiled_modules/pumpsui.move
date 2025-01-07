module 0xf5a3ad78802f250b2c4896a68b112a7c03ca34a286b9a46c8060aa72982c96f1::pumpsui {
    struct PUMPSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUMPSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUMPSUI>(arg0, 6, b"PUMPSUI", b"Sui Pumpkin", b"Sui Pumpkin is a spooky meme token on the Sui blockchain , representing a mystical blue pumpkin  in Sui style .", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_dbf880b858.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUMPSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUMPSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

