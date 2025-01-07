module 0x221e0c6ca08c9051588e4fb3a5a2db02cf353e8c8854ded6fcf7cfe3b8dc9f13::sap {
    struct SAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAP>(arg0, 6, b"SAP", b"Satoshi Panda", b"The Happy Meme Coin With BTC Rewards", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_01_10_22_51_17_b4553cf689.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAP>>(v1);
    }

    // decompiled from Move bytecode v6
}

