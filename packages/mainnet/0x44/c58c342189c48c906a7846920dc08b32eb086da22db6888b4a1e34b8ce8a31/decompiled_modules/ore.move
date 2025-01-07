module 0x44c58c342189c48c906a7846920dc08b32eb086da22db6888b4a1e34b8ce8a31::ore {
    struct ORE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ORE>(arg0, 6, b"Ore", b"Ore Sui", b"Ore Sui will be the first HARD MONEY token on Sui! And the first dual-chain mining token! After the official launch of the dual-chain mining mining boosts and Airdrops for Ore Sui holders!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ore_Image_bd0544a879.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ORE>>(v1);
    }

    // decompiled from Move bytecode v6
}

