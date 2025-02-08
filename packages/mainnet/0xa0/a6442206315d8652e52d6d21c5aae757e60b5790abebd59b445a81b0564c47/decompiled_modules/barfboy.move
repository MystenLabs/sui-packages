module 0xa0a6442206315d8652e52d6d21c5aae757e60b5790abebd59b445a81b0564c47::barfboy {
    struct BARFBOY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BARFBOY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BARFBOY>(arg0, 9, b"Barfboy", b"Barf Boy", b"The memecoin so wild, itll have your portfolio mooning and your stomach turning! Born from the chaos of crypto rollercoasters, $BARFBOY is for the true degens who hodl through the nausea and embrace the ups, downs, and full-blown moon-induced motion sickness.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmYkYRjuhTNvaWyhDMLpp2y5RvrQGRQtWAJsd5GVHwD1g5")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BARFBOY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BARFBOY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BARFBOY>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

