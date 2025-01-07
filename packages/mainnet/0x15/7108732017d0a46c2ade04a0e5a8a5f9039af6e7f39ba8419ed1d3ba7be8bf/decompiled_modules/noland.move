module 0x157108732017d0a46c2ade04a0e5a8a5f9039af6e7f39ba8419ed1d3ba7be8bf::noland {
    struct NOLAND has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOLAND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOLAND>(arg0, 6, b"NOLAND", b"Noland", b"$NOLAND (Neuralink P1, Noland Arbough), the world's first brain-computer interface human. The first brain chip-driven transaction on Sui will send 80% of the supply to Noland, allowing Noland to regain glory on the Sui. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Tbfl_N9_XO_2ea4185e91.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOLAND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOLAND>>(v1);
    }

    // decompiled from Move bytecode v6
}

