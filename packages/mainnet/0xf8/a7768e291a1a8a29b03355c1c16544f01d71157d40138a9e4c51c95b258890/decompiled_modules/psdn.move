module 0xf8a7768e291a1a8a29b03355c1c16544f01d71157d40138a9e4c51c95b258890::psdn {
    struct PSDN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PSDN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PSDN>(arg0, 6, b"PSDN", b"PEPESEIDON", b" Splashing now on Sui, The ultimate fusion of meme culture and mythic power! This unique crypto token combines the playful essence of Pepe the Frog with the might of Poseidon, symbolizing both fun and strength.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_27_23_33_36_5caac7bafc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PSDN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PSDN>>(v1);
    }

    // decompiled from Move bytecode v6
}

