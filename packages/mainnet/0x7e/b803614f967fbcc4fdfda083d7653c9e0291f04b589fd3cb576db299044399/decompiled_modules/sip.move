module 0x7eb803614f967fbcc4fdfda083d7653c9e0291f04b589fd3cb576db299044399::sip {
    struct SIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIP>(arg0, 6, b"SIP", b"Sip", b"He do be sippin ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sip_520d72dff9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

