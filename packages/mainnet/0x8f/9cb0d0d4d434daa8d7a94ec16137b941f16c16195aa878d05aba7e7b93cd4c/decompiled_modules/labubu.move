module 0x8f9cb0d0d4d434daa8d7a94ec16137b941f16c16195aa878d05aba7e7b93cd4c::labubu {
    struct LABUBU has drop {
        dummy_field: bool,
    }

    fun init(arg0: LABUBU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LABUBU>(arg0, 6, b"LABUBU", b"Labubu on Sui", b"Meet Labubu: not just a toy, but a legend unfolding. Dive into the deep lore. Choose your side in history. The saga starts now.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/123_4b76f5f2de.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LABUBU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LABUBU>>(v1);
    }

    // decompiled from Move bytecode v6
}

