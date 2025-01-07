module 0x3f156ec7abfbccc447c43e1ad41629111f7a3ffde60c47f730cc3640deccf6e7::swhit {
    struct SWHIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWHIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWHIT>(arg0, 9, b"SWHIT", b"WheatChain", b"WheatChain (SWHIT) is a groundbreaking multi-chain digital asset protocol revolutionizing value creation and distribution in Web3. Our protocol leverages robust security and scalability to deliver seamless, efficient value generation mechanisms. Through social distribution and community-driven governance, WheatChain creates an ecosystem where every participant contributes to lasting digital wealth.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/wheat-eco/Aptos-Tokens/refs/heads/main/logos/SWHIT.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SWHIT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWHIT>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SWHIT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SWHIT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

