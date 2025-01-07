module 0x116cb7d8ddff5f80da5066321fd97e3fcc0b5d62bc06cbc3211bf7fbd6f03315::sape {
    struct SAPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAPE>(arg0, 6, b"Sape", b"CTO Bored ape", x"4272696e67696e67207468652053756920626f72656420617065206c697665200a4e6f207363616d207a6f6e652068657265", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000865029_bbc9f119d4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

