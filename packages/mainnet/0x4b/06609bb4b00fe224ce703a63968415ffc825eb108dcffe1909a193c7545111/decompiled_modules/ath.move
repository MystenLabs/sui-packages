module 0x4b06609bb4b00fe224ce703a63968415ffc825eb108dcffe1909a193c7545111::ath {
    struct ATH has drop {
        dummy_field: bool,
    }

    fun init(arg0: ATH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ATH>(arg0, 6, b"ATH", b"All trump high", b"All trump high a moment not to be forgotten ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000305676_53fef1a9af.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ATH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ATH>>(v1);
    }

    // decompiled from Move bytecode v6
}

