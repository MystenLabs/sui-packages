module 0xd7c517411ed44436b27256d1a9f5b29867b4efa2db04461cdd29145df8d3568b::rachop {
    struct RACHOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: RACHOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RACHOP>(arg0, 6, b"RACHOP", b"RachopSui", b"The Pirate Rachop Meme Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000962_71b1e49d30.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RACHOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RACHOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

