module 0xf7a5c1c8e22642f716d7fd19dac78879a2ea7d35cc3538bda863660798a29c9::supersui {
    struct SUPERSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUPERSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUPERSUI>(arg0, 6, b"SUPERSUI", b"HERO ON SUI", b"Introducing SuperSui, the playful yet powerful meme coin inspired by the heroic spirit of a fearless pup! Embodying strength, speed, and community spirit, SuperSui dons its mask and cape, ready to bring fun and excitement to the crypto world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/supersui_9d0118e817.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUPERSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUPERSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

