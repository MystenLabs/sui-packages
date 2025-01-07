module 0x1419cc16f74a5f7e701970976ecb268e76ebadd77ac9b7bdf2e6978645192a02::beerus {
    struct BEERUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEERUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEERUS>(arg0, 6, b"BEERUS", b"Beerus", b"Stop staring or youll get destroyed ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1090_d96054bfc3.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEERUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEERUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

