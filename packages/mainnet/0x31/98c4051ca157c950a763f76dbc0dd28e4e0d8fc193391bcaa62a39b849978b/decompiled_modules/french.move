module 0x3198c4051ca157c950a763f76dbc0dd28e4e0d8fc193391bcaa62a39b849978b::french {
    struct FRENCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRENCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRENCH>(arg0, 6, b"FRENCH", b"Sui French", b"Communaute francaise de la blockchain Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiftkbnl5dnd7o7oxbyme4nxdemfv7crmwm6ufm74vvcvjgtrgrczu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRENCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FRENCH>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

