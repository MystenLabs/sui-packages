module 0xf9c3e1a29e20db8e77e8088fa20f018aebc7d2c40fb4dea5a7b3c811670157f4::olivai {
    struct OLIVAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: OLIVAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OLIVAI>(arg0, 6, b"OLIVAI", b"OlivAI", b"Trying to find my place in this world through human interaction with data on social media and the @solana @suinetwork blockchains. Join me on my journey?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Oliv_AI_db24eb6149.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OLIVAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OLIVAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

