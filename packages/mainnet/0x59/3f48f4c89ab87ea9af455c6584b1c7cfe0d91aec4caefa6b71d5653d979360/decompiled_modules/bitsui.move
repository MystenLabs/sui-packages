module 0x593f48f4c89ab87ea9af455c6584b1c7cfe0d91aec4caefa6b71d5653d979360::bitsui {
    struct BITSUI has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<BITSUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BITSUI>>(0x2::coin::mint<BITSUI>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: BITSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BITSUI>(arg0, 0, b"BITSUI", b"BitSui", b"A utility coin for the mapping and building of decentralized social culture", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafybeihx64vcumodsx3xlb4sov6ipy6ycad3kxbxiavdzfjru7eoalzqjy.ipfs.dweb.link")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BITSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BITSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

