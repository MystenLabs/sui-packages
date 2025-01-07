module 0xfbedb7bccd30038c0d7ab8fa9ac9cc8840c8205b8d4a8d06e0bbebb814ce4b00::slm {
    struct SLM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLM>(arg0, 6, b"SLM", b"SUILAMA", b"SUILAMA, the rising star in the meme coin universe on the SUI blockchain. Much like Shiba Inu on Ethereum, SUILAMA brings a playful twist with its lama-themed charm. Embrace the whimsical world of SUILAMA, where crypto meets humor, and join the journey toward the next big meme coin sensation on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/D_D_D_D_D_D_D_D_7f31378438.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLM>>(v1);
    }

    // decompiled from Move bytecode v6
}

