module 0xa0eb917ec091fcf4bb03cf84e577b65a9aaef96dd6e65e0697627098e6aabdad::ava {
    struct AVA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AVA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AVA>(arg0, 6, b"AVA", b"AVA", b"AI Intern at Holoworld AI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://pbs.twimg.com/profile_images/1654902057646825473/GKppeqtS_400x400.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AVA>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AVA>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AVA>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

