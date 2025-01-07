module 0x6f765af4cb60e9d70d87e79bf06aa7fe88e8907965ebfdc6e1f9951e265ef505::pepe {
    struct PEPE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<PEPE>, arg1: 0x2::coin::Coin<PEPE>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<PEPE>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PEPE>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: PEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPE>(arg0, 6, b"PEPE", b"PEPE", b"Pepe Token is a playful and community-driven meme token on the Sui blockchain, inspired by the iconic internet meme, Pepe the Frog. With its roots in meme culture, Pepe Token aims to bring joy, laughter, and a touch of irreverence to the world of decentralized finance (DeFi). Built on the fast, secure, and scalable Sui network, Pepe Token is designed for fun yet offers real utility through community engagement, unique collectibles, and gamified features. Join the Pepe revolution and hop into a world where memes meet DeFi on the cutting edge of blockchain technology!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://res.cloudinary.com/dkpo6c3me/image/upload/v1727334460/pep_xgcge7.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPE>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<PEPE>, arg1: 0x2::coin::Coin<PEPE>) : u64 {
        0x2::coin::burn<PEPE>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<PEPE>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<PEPE> {
        0x2::coin::mint<PEPE>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

