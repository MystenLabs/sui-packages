module 0xb51965483a48a7163e52a6b8981acb72510b1fc361db98ba601cc0d392809c87::salty {
    struct SALTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SALTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SALTY>(arg0, 6, b"SALTY", b"SUI SALTY", b"The brighter you shine the darker your haters.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/salty_c363526439.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SALTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SALTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

