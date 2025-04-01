module 0x51b4fb5ea246abba13f4df1019c17442423244b221eb6dbc76139a3181c3734::fdyo {
    struct FDYO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FDYO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FDYO>(arg0, 9, b"FDYO", b"rfuil", b"kuyd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/4b9883656a25f713d2d38910c22e2494blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FDYO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FDYO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

