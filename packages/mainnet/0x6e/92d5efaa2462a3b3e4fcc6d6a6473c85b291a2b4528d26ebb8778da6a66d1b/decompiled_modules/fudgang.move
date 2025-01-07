module 0x6e92d5efaa2462a3b3e4fcc6d6a6473c85b291a2b4528d26ebb8778da6a66d1b::fudgang {
    struct FUDGANG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUDGANG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUDGANG>(arg0, 6, b"FUDGANG", b"Fuddies Gang", b"AI meme coin on $SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7e19236925cc4b573b16be821cc6b1f7890b0af394b11b4a5e67ce2ec4f48f74_51cfafdb25.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUDGANG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUDGANG>>(v1);
    }

    // decompiled from Move bytecode v6
}

