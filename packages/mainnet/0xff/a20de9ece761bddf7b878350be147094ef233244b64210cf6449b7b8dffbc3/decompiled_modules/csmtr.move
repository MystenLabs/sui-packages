module 0xffa20de9ece761bddf7b878350be147094ef233244b64210cf6449b7b8dffbc3::csmtr {
    struct CSMTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: CSMTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CSMTR>(arg0, 6, b"CSMTR", b"Coin Master", b"You re not just a Holder  you re a Master", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeih7enhjyypu2qsrdpun3jhskqhkkexziddzrjep5fzeebxwef2fru")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CSMTR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CSMTR>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

