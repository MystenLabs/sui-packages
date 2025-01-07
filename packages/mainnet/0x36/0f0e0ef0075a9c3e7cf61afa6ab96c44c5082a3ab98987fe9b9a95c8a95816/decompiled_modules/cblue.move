module 0x360f0e0ef0075a9c3e7cf61afa6ab96c44c5082a3ab98987fe9b9a95c8a95816::cblue {
    struct CBLUE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CBLUE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CBLUE>(arg0, 6, b"CBLUE", b"Chris Blue", b"Christ Brown but Blue", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_10_195055_8920921383.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CBLUE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CBLUE>>(v1);
    }

    // decompiled from Move bytecode v6
}

