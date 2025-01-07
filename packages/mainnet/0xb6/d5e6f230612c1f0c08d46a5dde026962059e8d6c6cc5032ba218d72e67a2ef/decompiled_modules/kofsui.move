module 0xb6d5e6f230612c1f0c08d46a5dde026962059e8d6c6cc5032ba218d72e67a2ef::kofsui {
    struct KOFSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOFSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOFSUI>(arg0, 6, b"KOFSUI", b"King of Sui", b"Splashing now on Sui, The ultimate fusion of meme culture and mythic power! This unique crypto token combines the playful essence of Pepe the Frog with the might of Poseidon, symbolizing both fun and strength", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_02_01_54_18_24bbdc76ea.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOFSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KOFSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

