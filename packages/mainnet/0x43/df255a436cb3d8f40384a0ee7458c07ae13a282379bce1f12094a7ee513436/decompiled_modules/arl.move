module 0x43df255a436cb3d8f40384a0ee7458c07ae13a282379bce1f12094a7ee513436::arl {
    struct ARL has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARL>(arg0, 6, b"ARL", b"ARUL", b"ARUL TOKEN IS PUM IT PUMMM GO RICH NOW BUY BUY BUY BUY ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000464752_f62bba79f9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ARL>>(v1);
    }

    // decompiled from Move bytecode v6
}

