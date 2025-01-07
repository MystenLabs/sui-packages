module 0x92586470da424f671027438615a3852a79fc133feaf275a4e822d583c1397a46::legotrump {
    struct LEGOTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEGOTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEGOTRUMP>(arg0, 6, b"LEGOTRUMP", b"Lego Trump", b"Meet LEGOTRUMP, The only coin where Trump builds his own wall, one brick at a time. No instructions needed!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_0b1c08cb3d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LEGOTRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LEGOTRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

