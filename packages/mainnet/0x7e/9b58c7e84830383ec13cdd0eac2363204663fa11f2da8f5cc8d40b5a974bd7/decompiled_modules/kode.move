module 0x7e9b58c7e84830383ec13cdd0eac2363204663fa11f2da8f5cc8d40b5a974bd7::kode {
    struct KODE has drop {
        dummy_field: bool,
    }

    fun init(arg0: KODE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KODE>(arg0, 6, b"KODE", b"KERNEL CODE", x"456d706f776572696e6720446576656c6f706572730a776974682041492d44726976656e20436f646520456666696369656e63790a436f646520536d61727465722c204e6f74204861726465722e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250116_210921_772_b89f77a107.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KODE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KODE>>(v1);
    }

    // decompiled from Move bytecode v6
}

