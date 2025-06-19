module 0x7a49e87aefa97692cc0767bf73b99f02db3c17424cffdf229fcd82c58c472435::suinake {
    struct SUINAKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINAKE>(arg0, 6, b"SUINAKE", b"Suinake Wif Hat", b"Suinake slither your way up.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibsv7kimcnhpkndkx6iqaj2dzfaqbxuuitbqyfs4dpvo4nnqjejie")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINAKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUINAKE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

