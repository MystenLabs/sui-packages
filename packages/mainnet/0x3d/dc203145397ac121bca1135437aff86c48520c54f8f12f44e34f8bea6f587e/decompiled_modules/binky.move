module 0x3ddc203145397ac121bca1135437aff86c48520c54f8f12f44e34f8bea6f587e::binky {
    struct BINKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BINKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BINKY>(arg0, 6, b"Binky", b"Binky Fish", b"I was passing by and found a fish pacifier, do you want to be my friend?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagen_2024_09_12_202007986_4ded90f779.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BINKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BINKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

