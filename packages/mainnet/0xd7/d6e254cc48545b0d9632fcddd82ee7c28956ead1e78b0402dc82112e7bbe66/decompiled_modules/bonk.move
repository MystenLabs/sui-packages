module 0xd7d6e254cc48545b0d9632fcddd82ee7c28956ead1e78b0402dc82112e7bbe66::bonk {
    struct BONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BONK>(arg0, 6, b"BONK", b"SUI BONK", b"Sui Bonk - The first Bonk on Sui. Inspired by Bonk on Solana which was created for the people in the hopes of giving everyone a \"Fair Shot\". Here on SUI we intended to do the same thing by giving everyone the fair shot they deserve. Everyone loves Bonk and we are his doppelgnger, it's now our turn to be a suiper special", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_8622_34953740a5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BONK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BONK>>(v1);
    }

    // decompiled from Move bytecode v6
}

