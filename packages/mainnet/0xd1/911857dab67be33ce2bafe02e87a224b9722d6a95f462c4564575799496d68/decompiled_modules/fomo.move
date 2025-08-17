module 0xd1911857dab67be33ce2bafe02e87a224b9722d6a95f462c4564575799496d68::fomo {
    struct FOMO has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<FOMO>, arg1: 0x2::coin::Coin<FOMO>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<FOMO>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<FOMO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<FOMO>>(0x2::coin::mint<FOMO>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: FOMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOMO>(arg0, 9, b"FOMO", b"FOMO Sui", b"As the first meme coin on PANS BOX, we will use all trading fees to buy back and burn FOMO.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://sapphire-electrical-butterfly-80.mypinata.cloud/ipfs/bafybeiak4bmpyumxulhwmjebyge66rsgh24mbab2ukf5ithplszrztizbq?pinataGatewayToken=xcuefeN27sbPSPJ-Tgq77oidEq3C9RNwkHroOOdb5YxQ5reeEMIH97R1cjA6UzVR?filename=kls.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FOMO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

