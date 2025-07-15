module 0x69f0a20b9aef096af54db4bf664dbe261db27ba6029a72a0ac0600477ad1e547::cerberus {
    struct CERBERUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CERBERUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CERBERUS>(arg0, 6, b"CERBERUS", b"BERU THE CERBERUS", b"often referred to as the hound of Under World, is a multi-headed dog that guards the gates of the Underworld to prevent the dead from leaving.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigoabtatneio3rcnb3t6ct3nuwlwkl52lcbp3n4iatnqvf6kedama")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CERBERUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CERBERUS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

