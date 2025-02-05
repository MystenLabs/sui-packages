module 0xdb3317b5d92567b9e4ea0be166bb3455c179e64a1b369614a7cf93ed1dc22457::suizen {
    struct SUIZEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIZEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIZEN>(arg0, 6, b"SuiZen", b"SUIZEN", b"\"SuiZen: Accompanying you on the path to prosperity and peace.\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/darling_a8c4be6959.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIZEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIZEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

