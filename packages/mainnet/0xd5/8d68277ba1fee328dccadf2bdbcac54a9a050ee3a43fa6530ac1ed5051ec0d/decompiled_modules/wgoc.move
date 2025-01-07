module 0xd58d68277ba1fee328dccadf2bdbcac54a9a050ee3a43fa6530ac1ed5051ec0d::wgoc {
    struct WGOC has drop {
        dummy_field: bool,
    }

    fun init(arg0: WGOC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WGOC>(arg0, 9, b"WGOC", b"TwoGirlOneCup", b"TwoGirlOneCup coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WGOC>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WGOC>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WGOC>>(v1);
    }

    // decompiled from Move bytecode v6
}

