module 0x1b4bce3322bc3304ca8cf53576315ac6e76873041c4ab23ecdbbb0425a8bcc39::zeg {
    struct ZEG has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZEG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZEG>(arg0, 6, b"Zeg", b"Zenigame", b"I am Jenny Turtle from Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/33_bc80ae45d4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZEG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZEG>>(v1);
    }

    // decompiled from Move bytecode v6
}

