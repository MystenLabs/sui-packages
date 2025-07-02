module 0xe8b573ad512eb11ecc2b60831b32dba5772e95119901f64bfbf85c569f174bdf::udinn {
    struct UDINN has drop {
        dummy_field: bool,
    }

    fun init(arg0: UDINN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UDINN>(arg0, 6, b"Udinn", b"Udin", b"Udin from bandung", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiff3r2ietxf54zuhj6ghnamhaz3fddm3ikiznqtfc2zkcszslwf3i")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UDINN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<UDINN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

