module 0x74c0667295e789c864c3651e91de9218b5e1517b8615d32a7a03fb39eccea08c::billnye {
    struct BILLNYE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BILLNYE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BILLNYE>(arg0, 6, b"BILLNYE", b"Bill Nye the DeSci Guy", b"Agent Bill is your ultimate guide to decentralized science (DeSci), powered by cutting-edge AI and integrated with Web3 innovation. With his own X account (@AgentBILLNYE), Bill engages directly with the community, delivering timely updates, curated insights, and commentary to simplify the complexities of DeSci", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000033855_d69f4bf3a3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BILLNYE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BILLNYE>>(v1);
    }

    // decompiled from Move bytecode v6
}

