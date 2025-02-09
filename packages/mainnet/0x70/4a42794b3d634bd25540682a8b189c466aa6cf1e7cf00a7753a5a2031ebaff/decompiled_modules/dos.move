module 0x704a42794b3d634bd25540682a8b189c466aa6cf1e7cf00a7753a5a2031ebaff::dos {
    struct DOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DOS>(arg0, 6, b"DOS", b"DOGEOS by SuiAI", b"'DogeOS: Wow, such operating system, very fast, many features:", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_0275_e9be5cf021.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DOS>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOS>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

