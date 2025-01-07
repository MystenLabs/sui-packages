module 0x53aafb025ed4ddba9ed1d96fbf84052f9ed35129af510aecfd1567a5ca9022a1::bk {
    struct BK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BK>(arg0, 6, b"BK", b"Bonga Kwenda", b"A Legend of Angolan music!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Bonga_e0644f7e86.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BK>>(v1);
    }

    // decompiled from Move bytecode v6
}

