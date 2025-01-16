module 0x46cd32faa8ed51797232cd7330f9454efafef8fcb35e009714b4747b764abf2b::thuphat {
    struct THUPHAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: THUPHAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THUPHAT>(arg0, 9, b"THUPHAT", b"Huybim", b"Tao cho biet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/11a40bd8-610d-442b-8595-1413454705a9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THUPHAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<THUPHAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

