module 0xa898ffe4b979340dfc904a038a0587d30bdfaf4fc5d07935f8f4d39ee088e5d::egirl {
    struct EGIRL has drop {
        dummy_field: bool,
    }

    fun init(arg0: EGIRL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EGIRL>(arg0, 6, b"EGIRL", b"Egirl", x"456769726c20636f696e2069732064656369746174656420746f20616c6c2075206f6e652068616e64207479706572206c6567656e64732c20636f6d65206a6f696e2074686520636f6d6d756e6974792c20616e642062757920757273656c6620616e20456769726c2e0a4f72206a75737420727562206f6e65206f7574207572206465636973696f6e2077656273697465206c696e6b2077696c6c2068656c70207520776974682074686174206f6e65203b29", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/log_A_cdc6a9a9f6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EGIRL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EGIRL>>(v1);
    }

    // decompiled from Move bytecode v6
}

