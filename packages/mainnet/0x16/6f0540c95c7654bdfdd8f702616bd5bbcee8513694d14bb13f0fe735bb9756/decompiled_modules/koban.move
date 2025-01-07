module 0x166f0540c95c7654bdfdd8f702616bd5bbcee8513694d14bb13f0fe735bb9756::koban {
    struct KOBAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOBAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOBAN>(arg0, 6, b"KOBAN", b"KOBAN THE CAT", x"244b4f42414e2069732061207574696c69747920746f6b656e20656d706f776572696e6720616e2065636f73797374656d0a244b4f42414e2063616e206265207573656420696e207469746c657320646576656c6f706564206279204c75636b79204b617420616e642074686972642070617274792073747564696f7320746f207075726368617365204e4654732c2070726f6772657373206661737465722c20616e6420666f72207374616b696e672e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0735_34414c8bf0.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOBAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KOBAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

