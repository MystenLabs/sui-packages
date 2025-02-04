module 0x1b32052a54691a39e2fc09d03ff16926828460b2d82728d9ff8e745af5dc7c67::deepcat {
    struct DEEPCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEEPCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEEPCAT>(arg0, 6, b"DEEPCAT", b"DeepCat AI", b"Dream big, build bigger. DeepCat AI helps developers turn ideas into intelligent agents that shape the future. What is your vision?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000033641_0f1109b980.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEEPCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEEPCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

