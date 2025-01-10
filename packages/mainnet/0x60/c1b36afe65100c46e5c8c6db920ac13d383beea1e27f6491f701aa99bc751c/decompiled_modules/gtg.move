module 0x60c1b36afe65100c46e5c8c6db920ac13d383beea1e27f6491f701aa99bc751c::gtg {
    struct GTG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GTG>(arg0, 6, b"GTG", b"Gino The Goblin", b"Introducing Gino The Goblin ($GTG)  the ultimate community-driven coin that's here to shake up the crypto space! At its core, $GTG is all about fun, engagement, and empowerment. This isnt just another coin; its a token designed to bring together a community of like-minded individuals who want to experience the thrill of the market while supporting each other. There will be more to come in stages", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_20250110_121207_Chrome_75a9ce95b3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GTG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GTG>>(v1);
    }

    // decompiled from Move bytecode v6
}

