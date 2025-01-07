module 0x72e97eea0a3efbf5bb3d12b599f9e7836eafccad431be396726ef8adcb177d87::hdb {
    struct HDB has drop {
        dummy_field: bool,
    }

    fun init(arg0: HDB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HDB>(arg0, 6, b"HDB", b"Holiday dog", b"Lets blow this to 1 million today no sells only buys", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5769_b4ccff3670.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HDB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HDB>>(v1);
    }

    // decompiled from Move bytecode v6
}

