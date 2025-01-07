module 0xe3c147b74521317802d4085cf18d14c04ccb00b6f65e3b699b859ab22394ec19::bluey {
    struct BLUEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUEY>(arg0, 6, b"Bluey", b"Bluey The Dog", x"456d6261726b206f6e20616e20616476656e74757265207468726f75676820746865205355492d7665727365207769746820426c7565792074686520446f672c207768657265206372656174697669747920616e64206d656d6573206d6565742063757474696e672d6564676520746563686e6f6c6f67790a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/LOGO_01_0e64475930_b1706530fe.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

