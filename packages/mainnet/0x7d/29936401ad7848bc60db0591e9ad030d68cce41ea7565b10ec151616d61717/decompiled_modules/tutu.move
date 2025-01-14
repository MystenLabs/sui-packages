module 0x7d29936401ad7848bc60db0591e9ad030d68cce41ea7565b10ec151616d61717::tutu {
    struct TUTU has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUTU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUTU>(arg0, 6, b"TUTU", b"Tutu baby shark", b"Tutu baby shark is a baby blue shark with sharp fins, a sly smile, and a white diaper that steals the spotlight.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_6066610171838318475_y_7a531a90d6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUTU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TUTU>>(v1);
    }

    // decompiled from Move bytecode v6
}

