module 0xc51a2e0255ef7167f7ab7e08d52cd90c4343ba93fd66e2ecaabf7bfdae0dcbab::wlob {
    struct WLOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: WLOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WLOB>(arg0, 9, b"WLOB", b"WAL-BLOB", b"meme sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/b9bd4a3fd873f59b1a16edf16f9ea904blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WLOB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WLOB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

