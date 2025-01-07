module 0xf6c98830a7179ae60e9a88777e10d62c56ba46052a8dc517e148c32711cbc581::bin {
    struct BIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIN>(arg0, 6, b"BIN", b"Man In Bin", b"Can a man in a bin flip Solana?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/man_in_bin_60f63c63f3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

