module 0x4393732efa8a3511843856a2ed6ac0651c832a420d3e93923ecd71b252cc549::siuuu {
    struct SIUUU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIUUU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIUUU>(arg0, 6, b"Siuuu", b"Cristiano", x"41726520796f7520726561647920746f2063656c656272617465206c696b652074686520472e4f2e412e542e3f200a496e74726f647563696e6720437269737469616e6f2053697575752028534955292c2074686520746f6b656e20696e73706972656420627920526f6e616c646f73206c6567656e64617279200a225369757575757575757521222063656c6562726174696f6e21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SIUUUUUU_1_fd9e370461.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIUUU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIUUU>>(v1);
    }

    // decompiled from Move bytecode v6
}

