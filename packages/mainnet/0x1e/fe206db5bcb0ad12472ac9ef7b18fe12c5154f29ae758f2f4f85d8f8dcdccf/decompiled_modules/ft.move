module 0x1efe206db5bcb0ad12472ac9ef7b18fe12c5154f29ae758f2f4f85d8f8dcdccf::ft {
    struct FT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FT>(arg0, 9, b"FT", b"BTCFUN", b"GOOD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/3bdab5c30ce85dbbc1089203ec9f618bblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

