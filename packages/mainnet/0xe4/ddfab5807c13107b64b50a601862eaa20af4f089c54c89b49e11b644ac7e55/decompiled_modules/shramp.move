module 0xe4ddfab5807c13107b64b50a601862eaa20af4f089c54c89b49e11b644ac7e55::shramp {
    struct SHRAMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHRAMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHRAMP>(arg0, 6, b"SHRAMP", b"SUI SHRAMP", b"A hopeful shrimp on the Sui network, flipping McDonald's burgers by day and degening into memecoins by night. Dreaming of hitting it big and leaving the fryer for a whale's life.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SHRAMP_89849d28d0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHRAMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHRAMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

