module 0x61960b270ac4824bdd09869201e84a0fe3aef26f81e4d513ebdcf0b0fca96a61::zbec {
    struct ZBEC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZBEC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZBEC>(arg0, 6, b"ZBEC", b"ZBEC Token", b"ZBEC Token stealth launch", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreia6txsamfaa365wbqmbvpmgtp2gjyjsqtvlaful55pxisfdtwdmei")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZBEC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ZBEC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

