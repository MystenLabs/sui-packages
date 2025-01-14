module 0x706f3b435fdf026c2681cf53ca25859898bd72c125dc9ceaf588642507d5f576::doku {
    struct DOKU has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOKU>(arg0, 6, b"DOKU", b"DOKU SUI", x"446f6b752049736e277420796f757220617665726167652063727970746f206d6173636f742e204865277320610a7175616e74756d20616e6f6d616c79206f66206a6f792c20612077616c6b696e672070617261646f78206f660a66696e616e6369616c20776973646f6d20616e642061646f7261626c6520636f6e667573696f6e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dokuu_79fed0f677.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOKU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOKU>>(v1);
    }

    // decompiled from Move bytecode v6
}

