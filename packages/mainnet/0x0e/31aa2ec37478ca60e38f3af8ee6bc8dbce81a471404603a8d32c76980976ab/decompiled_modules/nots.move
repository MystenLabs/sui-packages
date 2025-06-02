module 0xe31aa2ec37478ca60e38f3af8ee6bc8dbce81a471404603a8d32c76980976ab::nots {
    struct NOTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOTS>(arg0, 6, b"NOTS", b"Notsuicoin", b"Not sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreia27popchiu3xbf3gysquuefc5whlo6ic3pve7lteiud7y3hkk43m")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NOTS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

