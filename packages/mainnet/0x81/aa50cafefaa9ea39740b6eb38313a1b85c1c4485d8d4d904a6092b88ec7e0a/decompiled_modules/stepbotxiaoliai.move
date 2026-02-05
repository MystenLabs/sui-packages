module 0x81aa50cafefaa9ea39740b6eb38313a1b85c1c4485d8d4d904a6092b88ec7e0a::stepbotxiaoliai {
    struct STEPBOTXIAOLIAI has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<STEPBOTXIAOLIAI>, arg1: 0x2::coin::Coin<STEPBOTXIAOLIAI>) {
        0x2::coin::burn<STEPBOTXIAOLIAI>(arg0, arg1);
    }

    fun init(arg0: STEPBOTXIAOLIAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEPBOTXIAOLIAI>(arg0, 6, b"STEPBOT", b"stepbot_xiaoli_ai", x"e585b3e6b3a8e5928ce58886e69e90e585b3e4ba8e41492be7a791e7a0942fe7949fe4bfa1e58886e69e90e5898de6b2bfe8b584e8aeafe4b88ee5ae9ee8b7b5e68a80e5b7a7", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1862337361587179520/JvjxPbl__400x400.jpg#1770274688345736000")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STEPBOTXIAOLIAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEPBOTXIAOLIAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<STEPBOTXIAOLIAI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<STEPBOTXIAOLIAI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

