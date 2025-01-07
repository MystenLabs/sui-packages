module 0xcbe6029f0551cc510c39d1b15c4e1e2549051db4e866e0e695275b35ebe3592::pipe {
    struct PIPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIPE>(arg0, 6, b"PIPE", b"Pirate PEPE", x"41686f792074686572652c206d61746579212057656c636f6d652061626f617264206f757220736869702120200a0a4361707461696e205049504520", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_15_14_57_57_ffdf8d2236.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

