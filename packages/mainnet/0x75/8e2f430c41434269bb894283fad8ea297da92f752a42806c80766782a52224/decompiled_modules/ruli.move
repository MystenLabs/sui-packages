module 0x758e2f430c41434269bb894283fad8ea297da92f752a42806c80766782a52224::ruli {
    struct RULI has drop {
        dummy_field: bool,
    }

    fun init(arg0: RULI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RULI>(arg0, 6, b"RULI", b"SUI TEST", b"Testing.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Capture_15d70c58cd.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RULI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RULI>>(v1);
    }

    // decompiled from Move bytecode v6
}

