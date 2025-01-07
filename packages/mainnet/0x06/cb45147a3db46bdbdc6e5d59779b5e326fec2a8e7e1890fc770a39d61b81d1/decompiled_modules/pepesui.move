module 0x6cb45147a3db46bdbdc6e5d59779b5e326fec2a8e7e1890fc770a39d61b81d1::pepesui {
    struct PEPESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPESUI>(arg0, 6, b"PEPESUI", b"PEPESUIDON", b" Splashing now on Sui, The ultimate fusion of meme culture and mythic power! This unique crypto token combines the playful essence of Pepe the Frog with the might of Poseidon, symbolizing both fun and strength.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_26_22_04_00_641890bca1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

