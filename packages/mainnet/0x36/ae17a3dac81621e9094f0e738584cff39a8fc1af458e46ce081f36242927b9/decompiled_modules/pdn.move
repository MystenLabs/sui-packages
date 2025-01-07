module 0x36ae17a3dac81621e9094f0e738584cff39a8fc1af458e46ce081f36242927b9::pdn {
    struct PDN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PDN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PDN>(arg0, 6, b"PDN", b"PEPESEIDON", b"Splashing now on Sui, The ultimate fusion of meme culture and mythic power! This unique crypto token combines the playful essence of Pepe the Frog with the might of Poseidon, symbolizing both fun and strength.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_26_22_04_00_0b943ec93d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PDN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PDN>>(v1);
    }

    // decompiled from Move bytecode v6
}

