module 0xd4fd2fb950063e14ef3dd09007fdbc9bef4792b041c08b31c93df92e93d12e5a::sbrett {
    struct SBRETT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBRETT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBRETT>(arg0, 6, b"SBRETT", b"SUIBRETT", x"46726f6d20244241534520746f20245355492c2053756942726574742065766f6c7665642c206661737465722c207374726f6e6765722c20616e6420726561647920746f206d6f6f6e20616e79206d656d65636f696e20696e2068697320706174682120245342524554540a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_14_20_00_58_015ccee741_1b13601740.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBRETT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBRETT>>(v1);
    }

    // decompiled from Move bytecode v6
}

