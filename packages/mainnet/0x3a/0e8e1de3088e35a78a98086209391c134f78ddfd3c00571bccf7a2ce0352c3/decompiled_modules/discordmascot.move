module 0x3a0e8e1de3088e35a78a98086209391c134f78ddfd3c00571bccf7a2ce0352c3::discordmascot {
    struct DISCORDMASCOT has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DISCORDMASCOT>, arg1: vector<0x2::coin::Coin<DISCORDMASCOT>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<DISCORDMASCOT>>(&mut arg1);
        0x2::pay::join_vec<DISCORDMASCOT>(&mut v0, arg1);
        0x2::coin::burn<DISCORDMASCOT>(arg0, 0x2::coin::split<DISCORDMASCOT>(&mut v0, arg2, arg3));
        if (0x2::coin::value<DISCORDMASCOT>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<DISCORDMASCOT>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<DISCORDMASCOT>(v0);
        };
    }

    fun init(arg0: DISCORDMASCOT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmT3fU4Ajftv1DafycYVtDbvfh2bkhCZooaQu9bee28t1A"));
        let (v2, v3) = 0x2::coin::create_currency<DISCORDMASCOT>(arg0, 9, b"NELLY", b"DiscordMascot", b"Nelly, the Robot Hamster on SUI! | Discords 404 Page Mascot", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DISCORDMASCOT>>(v3);
        0x2::coin::mint_and_transfer<DISCORDMASCOT>(&mut v4, 1000000000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DISCORDMASCOT>>(v4, v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DISCORDMASCOT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DISCORDMASCOT>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<DISCORDMASCOT>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DISCORDMASCOT>>(arg0);
    }

    // decompiled from Move bytecode v6
}

