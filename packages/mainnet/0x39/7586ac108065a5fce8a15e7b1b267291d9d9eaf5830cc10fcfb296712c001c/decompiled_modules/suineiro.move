module 0x397586ac108065a5fce8a15e7b1b267291d9d9eaf5830cc10fcfb296712c001c::suineiro {
    struct SUINEIRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINEIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINEIRO>(arg0, 6, b"SUINEIRO", b"Neiro on Sui", x"54686520667574757265206f66206d656d6573206973206272696768742c20616e64204e4549524f206f6e20535549206973206c656164696e6720746865207761792120200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/u0rx_Azc1_400x400_6927cd04d6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINEIRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINEIRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

