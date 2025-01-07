module 0xe987db409238ad057111c11954f876d19e748a89860989786820255ecf6c54de::lostpepe {
    struct LOSTPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOSTPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOSTPEPE>(arg0, 6, b"LOSTPEPE", b"LostPepe On Sui", x"4c6f7374506570652069732061206d656d6520636f696e20696e737069726564206279207468652066616d6f75732050657065207468652046726f672c20726570726573656e74696e6720746865206a6f75726e6579206f66206265696e67206c6f737420696e2074686520766173742063727970746f206a756e676c650a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hg_Gep_Zps_400x400_559a064843.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOSTPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOSTPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

