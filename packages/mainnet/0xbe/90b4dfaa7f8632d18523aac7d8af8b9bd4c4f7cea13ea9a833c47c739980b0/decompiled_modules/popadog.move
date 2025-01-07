module 0xbe90b4dfaa7f8632d18523aac7d8af8b9bd4c4f7cea13ea9a833c47c739980b0::popadog {
    struct POPADOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPADOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPADOG>(arg0, 6, b"POPADOG", b"Popa Dog on sui", b"Whos the most loved dog on Sui? The answer is clear: Pepes Dog, $POPA! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000098282_9ddeffcccf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPADOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPADOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

