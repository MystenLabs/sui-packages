module 0x14e376688216d81d4b1bcae7cfd6c1aa3724649ba7c1ba71e2b57c652ebbbd6d::bosssui {
    struct BOSSSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOSSSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOSSSUI>(arg0, 6, b"BossSui", b"Final Boss Sui", b"Final Boss on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeif7uom7lx2ejkpvtye2karhr4aqtem3lkencdyaxwkfrkwdpddl2q")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOSSSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BOSSSUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

