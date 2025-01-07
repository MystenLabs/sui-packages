module 0x317754371d35898bfd252720d2548d2036d4a437fa66ae1ebce62dc7472fa642::whuna {
    struct WHUNA has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHUNA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHUNA>(arg0, 6, b"WHUNA", b"Whale Luna", x"5768616c65204c756e613a207468652063757465737420696e20746865206f6365616e21205769746820686572207368696d6d6572696e6720626c756520736b696e20616e6420706c617966756c207370697269742c20736865206272696e6773206a6f7920746f20616c6c2077686f20656e636f756e746572206865722062656e65617468207468652077617665732e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Messenger_creation_0_DB_99103_8634_43_DC_A9_B8_406435999_E2_A_0a437e9af5.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHUNA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WHUNA>>(v1);
    }

    // decompiled from Move bytecode v6
}

