module 0x48b646f36bffaf6ae45920d43f89dd260c34170e46bcf3497f6c6d35a23d9a2d::samsui {
    struct SAMSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAMSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAMSUI>(arg0, 9, b"samsui", b"Sam SUI", b"Sam SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://interestprotocol.infura-ipfs.io/ipfs/QmaHxXK6Ch8TC9RVJQdbVvavUe695zSztZfGMHdWGeGFVZ")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAMSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAMSUI>>(v1);
    }

    // decompiled from Move bytecode v7
}

