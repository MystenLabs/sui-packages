module 0x320f328109234b0ed4a6466bb6ac5bc6a53b1ae3661ab9dc634431cfb0f89bf3::america {
    struct AMERICA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMERICA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMERICA>(arg0, 6, b"AMERICA", b"AMERICA GREAT", b"Make America Great Again...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SELLO_7d02c33ef8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMERICA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AMERICA>>(v1);
    }

    // decompiled from Move bytecode v6
}

