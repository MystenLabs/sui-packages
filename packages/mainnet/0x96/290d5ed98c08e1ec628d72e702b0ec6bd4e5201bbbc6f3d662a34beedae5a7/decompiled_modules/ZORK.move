module 0x96290d5ed98c08e1ec628d72e702b0ec6bd4e5201bbbc6f3d662a34beedae5a7::ZORK {
    struct ZORK has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZORK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZORK>(arg0, 9, b"ZORK", b"ZORK", b"ZORK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d391b93f5f62d9c15f67142e43841acc.ipfscdn.io/ipfs/bafybeigxr67nyettpf2kgognrebqton5vr53rijpzmdudj2x4ukk6dqwcq/bafkreifo4euhext6ul7mgy5jyboyy6k52ts3mpy6x3jjse7deziod75gya.ipfs.nftstorage.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZORK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZORK>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ZORK>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<ZORK>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

