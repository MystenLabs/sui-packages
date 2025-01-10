module 0xef23d31fd39063795024cb3fa78ac70e22af0792ce1da7aadd232906f46f8442::slop {
    struct SLOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLOP>(arg0, 9, b"SLOP", b"Slop Father", x"416c6c20746861742069732062656175746966756c207374617274732066726f6d20736c6f70e280a6616e6420696e6576697461626c79e280a62072657475726e7320746f20736c6f702e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/bc15561b6a9ab386f1cda7a6189498ceblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SLOP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLOP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

