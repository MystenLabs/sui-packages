module 0xd7da75e9bc8303ff08e1c7eea4dd847444881eedf7a2e895938a19523608bf93::gtg {
    struct GTG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GTG>(arg0, 6, b"GTG", b"GINO THE GOBLIN", b"Introducing Gino The Goblin ($GTG)  the ultimate community-driven coin that's here to shake up the crypto space! At its core, $GTG is all about fun, engagement, and empowerment. This isnt just another coin; its a token designed to bring together a community of like-minded individuals who want to experience the thrill of the market while supporting each other.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_20250110_121207_Chrome_3142311596.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GTG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GTG>>(v1);
    }

    // decompiled from Move bytecode v6
}

