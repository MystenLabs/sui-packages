module 0xfd175c831deb74d189d11b0fe70a1bfbd684c1d9788695d8a4ca8cf5071a7c67::frmr {
    struct FRMR has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRMR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRMR>(arg0, 6, b"FRMR", b"Farmer", x"547279696e672061206d656d6520636f696e20666f72207468652066697273742074696d65210a4f6e6c7920696e76657374207768617420796f7520636f756c64206166666f726420746f206c6f6f73650a4e6f207363616d6d0a4f6e6c7920666f722066756e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730991935795.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FRMR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRMR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

