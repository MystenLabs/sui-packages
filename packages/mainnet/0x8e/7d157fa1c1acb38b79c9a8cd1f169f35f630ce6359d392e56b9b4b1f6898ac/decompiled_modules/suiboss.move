module 0x8e7d157fa1c1acb38b79c9a8cd1f169f35f630ce6359d392e56b9b4b1f6898ac::suiboss {
    struct SUIBOSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBOSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBOSS>(arg0, 6, b"SUIBOSS", b"Sui Final Boss", b"Sui FInal Boss on Ibiza", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiel5gphcrmo37v6txqmlslwd5dkfscmfe6qzp3e5clomqfb3pwxyu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBOSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIBOSS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

