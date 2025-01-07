module 0xa44e68263ae0d4b877a360e9640d8e6d1b3db13c42e6a9b8ab01fb288fd19353::vemint {
    struct VEMINT has drop {
        dummy_field: bool,
    }

    fun init(arg0: VEMINT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VEMINT>(arg0, 6, b"VEMINT", b"VEMINT VENTURE", x"446563656e7472616c697a656420436c6f756420476f7665726e616e6365207072696e6369706c65732e205573696e672046696e616e63657320646563656e7472616c697a6174696f6e2d666972737420676f7665726e616e6365206d6f64656c2e20496e74656772617465642077697468205355492045636f73797374656d2e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_05_26_20_15_12_726bcf332e_1a35634552.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VEMINT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VEMINT>>(v1);
    }

    // decompiled from Move bytecode v6
}

