module 0x6d9dd8fe9a2669bfaa1e4b18a07c1a8c51b1c9711247c695e5b6037a25800d10::pish {
    struct PISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: PISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PISH>(arg0, 6, b"PISH", b"Pishi", b"Ar-ar-ar! Ar-ar-ar! Ar-ar-ar! Ar-ar-ar!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/aasd_6fde259a14.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

