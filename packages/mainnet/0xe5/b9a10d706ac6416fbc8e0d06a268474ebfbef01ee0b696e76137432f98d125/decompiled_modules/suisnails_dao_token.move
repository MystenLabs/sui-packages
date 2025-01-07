module 0xe5b9a10d706ac6416fbc8e0d06a268474ebfbef01ee0b696e76137432f98d125::suisnails_dao_token {
    struct SUISNAILS_DAO_TOKEN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUISNAILS_DAO_TOKEN>, arg1: 0x2::coin::Coin<SUISNAILS_DAO_TOKEN>) {
        0x2::coin::burn<SUISNAILS_DAO_TOKEN>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUISNAILS_DAO_TOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUISNAILS_DAO_TOKEN>>(0x2::coin::mint<SUISNAILS_DAO_TOKEN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SUISNAILS_DAO_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISNAILS_DAO_TOKEN>(arg0, 6, b"SNAIL", b"Sui Snails Dao Token", b"Tokenized Ownership of the Sui Snails Corporation", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafybeicxo6s7wu62dxzurmvnmqqadinpr37p2wm6fou6srotsictjgp3ia.ipfs.nftstorage.link/")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUISNAILS_DAO_TOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISNAILS_DAO_TOKEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

