module 0x643500f2b8261755ba87622137c03d34493d992d4bc1e2afd96240ae81ddfe07::bsc {
    struct BSC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSC>(arg0, 6, b"BSC", b"BabySUICAT", b"First Cat On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/B_Gtk_D41a_400x400_c0b1051af3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BSC>>(v1);
    }

    // decompiled from Move bytecode v6
}

