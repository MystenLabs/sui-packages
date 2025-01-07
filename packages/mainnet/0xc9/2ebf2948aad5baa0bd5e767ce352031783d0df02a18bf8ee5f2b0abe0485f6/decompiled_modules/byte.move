module 0xc92ebf2948aad5baa0bd5e767ce352031783d0df02a18bf8ee5f2b0abe0485f6::byte {
    struct BYTE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BYTE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BYTE>(arg0, 6, b"BYTE", b"BYTE ON SUI", b"Byte is a playful memecoin on Sui that's ready to take a big bite out of the market. With its fun-loving community and potential for growth, Byte is more than just a meme. It's a chance to be part of something exciting.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1241241242131_2fed1d7d4f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BYTE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BYTE>>(v1);
    }

    // decompiled from Move bytecode v6
}

