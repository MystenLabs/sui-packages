module 0xb109651e79b7c0602b5581bbd72da37b305bbfe55b01d5c461340f324e915a99::bobo {
    struct BOBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOBO>(arg0, 6, b"BOBO", b"Bobo on SUI", b"Bobo the Bear is a meme character associated with bear markets. The design of Bobo is based on Apu Apustaja, and sometimes Pepe the Frog. The name Bobo was chosen in June 2018, and has become the official name for the character.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_14_1a6d4e7e8e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

