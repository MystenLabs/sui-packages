module 0x39bb594faee5ebcef34f906ccce3f33645632b89e74f370b9b06494d1ffc13d::elder {
    struct ELDER has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELDER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELDER>(arg0, 6, b"ELDER", b"ElderWorld", b"ElderWorld is evoloving", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifcjakuziz5cboiqyaj7eze6wyytl57mravztcydwrrnzp5dfo3im")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELDER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ELDER>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

