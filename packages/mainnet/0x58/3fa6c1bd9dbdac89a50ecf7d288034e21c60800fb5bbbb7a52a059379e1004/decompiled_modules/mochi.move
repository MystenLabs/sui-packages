module 0x583fa6c1bd9dbdac89a50ecf7d288034e21c60800fb5bbbb7a52a059379e1004::mochi {
    struct MOCHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOCHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOCHI>(arg0, 6, b"MOCHI", b"Mochi On Sui", x"54686520666c7566666c792c207371756973687920616e642068756e67727920626c6f62206c6976696e67206869732062657374206c69666520696e207468652053756920756e697665727365207c2020444f4e5420425559204d4f43484920746865204c5020697320656d707479207c0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/WR_7_Hev86_400x400_91d6ee0b8b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOCHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOCHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

