module 0xfce7a53d4e9b6680de5f09bc5c0dc9e79f418e1a58871cc271ad60287e68f976::scartrump {
    struct SCARTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCARTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCARTRUMP>(arg0, 6, b"SCARTRUMP", b"ScarTrump on Sui", b"Enter the world of ScarTrump, where the boldness of Scarface meets the charisma of Trump! This meme coin project combines the swagger and ambition of Scarface with Trump's unique personality. Join our community to witness the dramatic and adventurous exploits of ScarTrump, where every move is larger than life and every moment is filled with excitement!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2_d52bd3278d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCARTRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCARTRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

