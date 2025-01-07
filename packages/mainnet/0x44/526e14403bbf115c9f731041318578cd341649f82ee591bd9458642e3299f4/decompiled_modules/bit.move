module 0x44526e14403bbf115c9f731041318578cd341649f82ee591bd9458642e3299f4::bit {
    struct BIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIT>(arg0, 6, b"Bit", b"Bittern Sui", x"54686520657261206f66204269747465726e2068617320636f6d6520746f2053756920616e642074686572652077696c6c2062652061206269672062616e6720686572650a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_02_23_14_25_4839e62eb1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

