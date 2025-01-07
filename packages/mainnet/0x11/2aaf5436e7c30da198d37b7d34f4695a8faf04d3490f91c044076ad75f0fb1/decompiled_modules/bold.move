module 0x112aaf5436e7c30da198d37b7d34f4695a8faf04d3490f91c044076ad75f0fb1::bold {
    struct BOLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOLD>(arg0, 6, b"BOLD", b"BOLD on SUI", b"It would appear Ive entered some sort of limbo where I trade loads and even though all the coins are going up my total dollar value stays the same.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/zx_Of_I_KX_400x400_60f6f5cb7a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOLD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOLD>>(v1);
    }

    // decompiled from Move bytecode v6
}

