module 0xe7bd08c87dac960f096720b2a238b24f58dc1d223aa08f12cf6388b040d2e82f::pss {
    struct PSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PSS>(arg0, 6, b"PSS", b"PEPESAMSULLEK", b"PepeSulek (PSS) Memecoin is a unique cryptocurrency that merges the fitness-driven ethos of Sam Sulek with the iconic and humorous appeal of Pepe the Frog. This memecoin is designed to foster a community of fitness enthusiasts and meme lovers, offering incentives for healthy living and active participation in the digital world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sqqqq_ce61dcb0e0.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

