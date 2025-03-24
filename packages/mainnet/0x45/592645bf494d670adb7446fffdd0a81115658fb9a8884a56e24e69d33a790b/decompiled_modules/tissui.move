module 0x45592645bf494d670adb7446fffdd0a81115658fb9a8884a56e24e69d33a790b::tissui {
    struct TISSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TISSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TISSUI>(arg0, 6, b"TISSUI", b"tisSUI", b"$tisSUI is a Community based Memecoin. Being no.1 is a priority.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000012075_9e34952d40.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TISSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TISSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

