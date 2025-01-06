module 0x5786e80b47cec237675a216d225a46ee850c7aa865eef70aa37e860f6dd9e96c::suidepin {
    struct SUIDEPIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDEPIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDEPIN>(arg0, 6, b"SUIDEPIN", b"SUI DEPIN", b"SUI DEPIN is the first modular data AI networkthat we proudly call the AI Layer of the Internet. Our main goal is to enable billions of devices, AI agents, and data owners to securely transact and monetize their data. But beyond the technical jargon, SUI DEPIN is about creating a fair, decentralized, and scalable ecosystem that empowers users and businesses alike.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/unnamed_29f39ea260.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDEPIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDEPIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

