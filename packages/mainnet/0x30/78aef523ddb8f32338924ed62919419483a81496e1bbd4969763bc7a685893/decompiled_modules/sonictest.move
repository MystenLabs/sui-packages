module 0x3078aef523ddb8f32338924ed62919419483a81496e1bbd4969763bc7a685893::sonictest {
    struct SONICTEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: SONICTEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SONICTEST>(arg0, 9, b"SonicTest", b"SonicTest", b"This is a Test Token For Testing Sonic Snipe Bot Launchpad on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SONICTEST>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SONICTEST>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SONICTEST>>(v1);
    }

    // decompiled from Move bytecode v6
}

