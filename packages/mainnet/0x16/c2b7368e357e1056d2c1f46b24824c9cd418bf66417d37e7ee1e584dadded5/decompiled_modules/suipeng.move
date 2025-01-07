module 0x16c2b7368e357e1056d2c1f46b24824c9cd418bf66417d37e7ee1e584dadded5::suipeng {
    struct SUIPENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPENG>(arg0, 6, b"SuiPeng", b"Gus The King Penguin", x"4d656574204775732c2074686520776f726c6473206d6f73742066616d6f75732050656e6775696e206973206e6f77206f6e207468652053554920626c6f636b636861696e2e200a4a6f696e20616e20616476656e7475726520746f20332e333362206d61726b657420636170200a28316d206d61726b65742063617020666f72206576657279206b696c6f6d6574657220477573207377616d29", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_26_17_07_42_960c986d29.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

