module 0xeaedf4f36ab21f453baaad044c550d63603a43010fa4a1e3ce19eb461bdb1cb7::dod {
    struct DOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOD>(arg0, 6, b"DOD", b"Dod Coin", x"24444f442d204c6974746c6520446f672c2042696720447265616d2e20526964696e67207468652077696e6420696e746f20746865206e6578742067656e65726174696f6e206f66206d656d6520746f6b656e732e0a466c697070696e672074686520646f6c6c6172", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Dod_Coin_7cdf486780.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

