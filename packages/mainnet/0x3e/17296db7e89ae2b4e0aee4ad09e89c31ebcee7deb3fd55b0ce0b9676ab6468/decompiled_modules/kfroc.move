module 0x3e17296db7e89ae2b4e0aee4ad09e89c31ebcee7deb3fd55b0ce0b9676ab6468::kfroc {
    struct KFROC has drop {
        dummy_field: bool,
    }

    fun init(arg0: KFROC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KFROC>(arg0, 6, b"KFROC", b"King Froc", x"41206e6577206b696e6720686173206265656e20626f726e2c20697427730a6372617a7920627574206e6f7468696e672069730a696d706f737369626c65", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000043101_f299b1c511.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KFROC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KFROC>>(v1);
    }

    // decompiled from Move bytecode v6
}

