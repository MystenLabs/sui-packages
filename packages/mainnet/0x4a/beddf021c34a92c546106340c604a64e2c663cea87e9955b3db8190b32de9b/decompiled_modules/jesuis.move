module 0x4abeddf021c34a92c546106340c604a64e2c663cea87e9955b3db8190b32de9b::jesuis {
    struct JESUIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: JESUIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JESUIS>(arg0, 6, b"JESUIS", b"JESUS", b"Be welcome, my child.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_11_201016294_60d2529d11.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JESUIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JESUIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

