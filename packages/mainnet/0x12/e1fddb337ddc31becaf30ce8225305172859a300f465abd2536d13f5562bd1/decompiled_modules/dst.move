module 0x12e1fddb337ddc31becaf30ce8225305172859a300f465abd2536d13f5562bd1::dst {
    struct DST has drop {
        dummy_field: bool,
    }

    fun init(arg0: DST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DST>(arg0, 6, b"DST", b"Destinyworld", b"FEAR OF THE UNKNOWN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ss_512eb948d6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DST>>(v1);
    }

    // decompiled from Move bytecode v6
}

