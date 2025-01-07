module 0xb65e6363c913bbb6a48b21ec7cfa9470cd8e8d38d69edc90a8e45e0183d878e0::nsui {
    struct NSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NSUI>(arg0, 6, b"nSUI", b"First nigga on sui", b"Im, he, she, him, her nigga", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Tak_berjudul139_20241011131055_5456dd563b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

