module 0xd0f06d841999377fc19d0bc4c46307bcb895b7a92b3e4dacd5a1c1ded6cd436a::suistar {
    struct SUISTAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISTAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISTAR>(arg0, 6, b"SUISTAR", b"Suistar - the best Star", b"In the vast digital cosmos, Suistar was a star living on the SUI blockchain, shining with the energy of countless encrypted transactions. When a rogue entity known as \"The Glitch\" threatened to corrupt the decentralized network, Suistar pulsed with cryptographic power, safeguarding the integrity of the entire system. Now, Suistar remains a symbol of unbreakable trust, guiding the blockchain's future through the darkness.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_05_05_58_54_e82913e2d6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISTAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISTAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

