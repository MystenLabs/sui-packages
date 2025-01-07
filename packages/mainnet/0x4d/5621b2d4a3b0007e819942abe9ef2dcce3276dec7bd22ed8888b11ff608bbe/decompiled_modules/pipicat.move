module 0x4d5621b2d4a3b0007e819942abe9ef2dcce3276dec7bd22ed8888b11ff608bbe::pipicat {
    struct PIPICAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIPICAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIPICAT>(arg0, 6, b"PIPICAT", b"PIPICAT on SUI", b"PIPICAT: The purr-fectly ridiculous Solana meme token for the degenerate in all of us. Join the litter for a fur-ociously funny ride!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/X79_Jc_H9r_400x400_55d7e3aa97.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIPICAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIPICAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

