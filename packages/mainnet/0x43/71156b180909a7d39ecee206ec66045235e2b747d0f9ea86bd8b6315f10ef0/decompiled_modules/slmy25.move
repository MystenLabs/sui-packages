module 0x4371156b180909a7d39ecee206ec66045235e2b747d0f9ea86bd8b6315f10ef0::slmy25 {
    struct SLMY25 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLMY25, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLMY25>(arg0, 9, b"SLMY25", b"Slimey 2025", b"Does 2025 get a slimey year? ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/63c50d06a8d17a0c32c0bb324ee9a59fblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SLMY25>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLMY25>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

