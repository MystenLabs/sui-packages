module 0xa83fecf30944f46c255a6299fdc13c844b6c1a90d85d8e897338aae424e69829::bwgcoin {
    struct BWGCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BWGCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BWGCOIN>(arg0, 6, b"BWGCOIN", b"BLUE WHALE COIN", b"Phenomenon Whale of the #Sui Ocean", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_11_222033170_e8638e7e43.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BWGCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BWGCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

