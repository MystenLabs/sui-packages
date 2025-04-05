module 0x856d817770d13e031cc8b3ba197a7fdb2ee604200e8f99aab31d0f992af7d09e::flpws {
    struct FLPWS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLPWS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLPWS>(arg0, 9, b"FLPWS", b"Filipowski", b"my", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/de230f732429afa2ac32aadb0f4a6ca8blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLPWS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLPWS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

