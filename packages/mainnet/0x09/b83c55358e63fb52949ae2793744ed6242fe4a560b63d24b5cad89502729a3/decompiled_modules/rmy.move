module 0x9b83c55358e63fb52949ae2793744ed6242fe4a560b63d24b5cad89502729a3::rmy {
    struct RMY has drop {
        dummy_field: bool,
    }

    fun init(arg0: RMY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RMY>(arg0, 6, b"RMY", b"Rummy Gamez", x"52756d6d792047616d657a2070726f7669646573206120706c6174666f726d20666f722067616d65727320616e6420636172642066616e617469637320746f20706c61792c20696e766573742c20616e642077696e2e205472616e73666f726d696e6720747261646974696f6e616c2067616d657320746f20626c6f636b636861696e2e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_27_13_59_18_640f123c01.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RMY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RMY>>(v1);
    }

    // decompiled from Move bytecode v6
}

