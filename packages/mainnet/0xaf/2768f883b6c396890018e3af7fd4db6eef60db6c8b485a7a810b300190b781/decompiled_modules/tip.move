module 0xaf2768f883b6c396890018e3af7fd4db6eef60db6c8b485a7a810b300190b781::tip {
    struct TIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIP>(arg0, 6, b"TIP", b"Tipsy", b"Boozing my sorrows in the oceans deep, a narwhal adrift in sorrows keep!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731287866442.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TIP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

