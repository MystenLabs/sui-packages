module 0x68071040151d37564c61afbe1cb6fff87c46e62b33d67e7231c3f310c20af4c::btc100k {
    struct BTC100K has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTC100K, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTC100K>(arg0, 6, b"BTC100K", b"Bitcoin100000K", b"For Teh Culture", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo111_cc16309584.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTC100K>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BTC100K>>(v1);
    }

    // decompiled from Move bytecode v6
}

