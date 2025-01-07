module 0x9460de98bae2dc796b0e7289ab9b165551472fe4fc003c2234e4289c20336e97::hsa {
    struct HSA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HSA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HSA>(arg0, 6, b"HSA", b"HYDROPOWER SUI ACCELERATOR", b"The Hydropower Sui Accelerator program is inviting the first cohort of Sui builders to join an exclusive journey towards business acceleration.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_10_212741_1a17280e3d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HSA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HSA>>(v1);
    }

    // decompiled from Move bytecode v6
}

