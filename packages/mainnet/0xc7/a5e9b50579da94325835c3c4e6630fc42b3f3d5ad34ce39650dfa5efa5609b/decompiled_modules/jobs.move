module 0xc7a5e9b50579da94325835c3c4e6630fc42b3f3d5ad34ce39650dfa5efa5609b::jobs {
    struct JOBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOBS>(arg0, 9, b"JOBS", b"Jean On Blast Sui", b"Memes for jean", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://files.catbox.moe/ghdf0d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JOBS>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOBS>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<JOBS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<JOBS>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v7
}

