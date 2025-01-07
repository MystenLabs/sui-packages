module 0xb0c639795f118988773a3e74d2da83870c5445f9107cfe8066b177abe1a15871::snurky {
    struct SNURKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNURKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNURKY>(arg0, 9, b"Snurky", b"Snurky Sui", x"536e75726b79202d206973206120766567616e20736861726b2077686f20697320616761696e737420656174696e67206d6561742c20656e6a6f79732073757266696e6720616e6420636f666665650a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/e0b1216e80197147de14e80ec0922d0dblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SNURKY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNURKY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

