module 0xc4996db5a4f216a049c7b6df563949e1c6a5406fc4816dc23c8ffb692a0aded3::ethical {
    struct ETHICAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: ETHICAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ETHICAL>(arg0, 6, b"ETHICAL", b"The Ethical Singularity", b"Where AI transcends intelligence to embody paradox-driven evolution, cosmic empathy, and playful governance.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000057769_0560a4aeab.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ETHICAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ETHICAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

