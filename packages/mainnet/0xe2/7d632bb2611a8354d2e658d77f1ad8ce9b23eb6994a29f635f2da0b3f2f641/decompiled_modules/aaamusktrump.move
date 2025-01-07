module 0xe27d632bb2611a8354d2e658d77f1ad8ce9b23eb6994a29f635f2da0b3f2f641::aaamusktrump {
    struct AAAMUSKTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAMUSKTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAMUSKTRUMP>(arg0, 6, b"AAAMUSKTRUMP", b"$AAA MUSK TRUMP", b"just meme for making vibe of musk and trump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_1_e3aa39a34f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAMUSKTRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAMUSKTRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

