module 0x37b18cfbb047325221064ebc3e9b48f2b5a55aeb305e130f5e32b2b589a6276b::su {
    struct SU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SU>(arg0, 6, b"SU", b"Sui universal", b"69 light years away from Earth, there exists the Sui Universea magical world of endless water planets all connected like streams in a great ocean. Here, life flows like water, guided by Naiadrum, the Sui God, who keeps everything in perfect balance. In this unique universe, Sui Water is not just something to drinkit's everything! It gives life, powers cities, fuels cars, and even drives the incredible technology that makes this world so extraordinary.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000056941_15e6d60a35.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SU>>(v1);
    }

    // decompiled from Move bytecode v6
}

