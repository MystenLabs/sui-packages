module 0xe32f33f87cc1438fc3add037eb373a932246726abc0bfbee52403c1d3afa22e7::wintb {
    struct WINTB has drop {
        dummy_field: bool,
    }

    fun init(arg0: WINTB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WINTB>(arg0, 6, b"WINTB", b"Winter Bear", b"WINTER BEAR ONE AND ONLY WINTER BEAR ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001747_61f1a2ba18.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WINTB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WINTB>>(v1);
    }

    // decompiled from Move bytecode v6
}

