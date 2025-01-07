module 0x137a91b8557ef74886fe50a09ac55a632d76eef9b0bd5594e66ad20674105480::sdwk {
    struct SDWK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDWK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDWK>(arg0, 6, b"SDWK", b"Sui duck with knife", b"Don't irritate me, or I'll kill you", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_624e561aa2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDWK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SDWK>>(v1);
    }

    // decompiled from Move bytecode v6
}

