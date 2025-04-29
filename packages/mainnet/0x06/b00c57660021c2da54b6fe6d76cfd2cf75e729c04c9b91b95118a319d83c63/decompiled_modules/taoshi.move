module 0x6b00c57660021c2da54b6fe6d76cfd2cf75e729c04c9b91b95118a319d83c63::taoshi {
    struct TAOSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAOSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAOSHI>(arg0, 6, b"TAOSHI", b"Taoshi", b"$TAOSHI is the first Bittensor created token built on the Sui network, and honorary mascot of the Bittensor network. Taoshi's mission is to bring awareness to both blockchains, as this little guy believes that both SUI and TAO are the future of crypto. Taoshi is a meme token with no intrinsic value - but he also likes to suprise his community with giveways and rewards! With the help of an enthusiastic community, Taoshi can reach his goal of becoming one of the faces of crypto and sit at the top of the meme token mountain, while changing lives along the way!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Taoshi_5d50ce0135.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAOSHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TAOSHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

