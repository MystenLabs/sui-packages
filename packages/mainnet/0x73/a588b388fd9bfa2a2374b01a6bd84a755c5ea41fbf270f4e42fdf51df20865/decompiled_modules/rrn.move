module 0x73a588b388fd9bfa2a2374b01a6bd84a755c5ea41fbf270f4e42fdf51df20865::rrn {
    struct RRN has drop {
        dummy_field: bool,
    }

    fun init(arg0: RRN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RRN>(arg0, 9, b"RRN", b"the rain", b"affectionate", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0c9ab49a-6c75-4d6d-8184-c8471dcd17e4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RRN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RRN>>(v1);
    }

    // decompiled from Move bytecode v6
}

