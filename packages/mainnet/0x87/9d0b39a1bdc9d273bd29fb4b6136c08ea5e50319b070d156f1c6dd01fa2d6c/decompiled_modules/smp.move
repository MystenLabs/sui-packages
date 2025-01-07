module 0x879d0b39a1bdc9d273bd29fb4b6136c08ea5e50319b070d156f1c6dd01fa2d6c::smp {
    struct SMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMP>(arg0, 6, b"SMP", b"Sui Meme Party", b"Welcome to the best meme party since the last memecoin season", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/smp_18198a003a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

