module 0xb6cd633d0c3a2adbe7dea116a31ca382e0e1268e7ffe727aefeb6995be4fb1c2::siren {
    struct SIREN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIREN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIREN>(arg0, 6, b"SIREN", b"Sui Siren", b"Sui powered Ai, to bring banter, satire, and fun back onto the blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiblbu5tmrvr7tc2jmf3vuyb3cxudjw33nkzt6k2tgfw4rimfodx7y")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIREN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SIREN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

