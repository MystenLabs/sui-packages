module 0x1d4684d70bfdd9062fc1793be7ed879527a45678fe131b8d15d8f088e57fffbb::suipiece {
    struct SUIPIECE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPIECE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPIECE>(arg0, 6, b"SuiPiece", b"LUFFY", b"Relaunch sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeidt4cfk3miwu55oqwc2bvedozy33gjlepm6cyfgyu2m7sytvea3qy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPIECE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIPIECE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

