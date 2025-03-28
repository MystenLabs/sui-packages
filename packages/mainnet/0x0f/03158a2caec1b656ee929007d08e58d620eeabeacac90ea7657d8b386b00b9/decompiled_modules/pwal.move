module 0xf03158a2caec1b656ee929007d08e58d620eeabeacac90ea7657d8b386b00b9::pwal {
    struct PWAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PWAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PWAL>(arg0, 9, b"pWAL", b"Patara Staked Walrus", b"Patara's Liquid Staking for Walrus", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://interestprotocol.infura-ipfs.io/ipfs/QmaHxXK6Ch8TC9RVJQdbVvavUe695zSztZfGMHdWGeGFVZ")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PWAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PWAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

