module 0x5b36595a0db75bcf2fd8c62bd2ebdfb3b21e0ad420fec9df77c94ccd13f64641::srtyjytj {
    struct SRTYJYTJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SRTYJYTJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SRTYJYTJ>(arg0, 9, b"SRTYJYTJ", b"yulydul", b"ku6e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/c6d7ed105584a3147b9d7bfdd11a3edfblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SRTYJYTJ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SRTYJYTJ>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

