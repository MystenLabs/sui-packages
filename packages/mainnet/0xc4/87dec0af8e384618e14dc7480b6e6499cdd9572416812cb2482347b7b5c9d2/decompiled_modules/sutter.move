module 0xc487dec0af8e384618e14dc7480b6e6499cdd9572416812cb2482347b7b5c9d2::sutter {
    struct SUTTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUTTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUTTER>(arg0, 6, b"SUTTER", b"Sui Otter", b"$SUTTER the cutest otter memecoin swimming on Sui Network! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sutter_removebg_preview_1_647f8ba356.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUTTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUTTER>>(v1);
    }

    // decompiled from Move bytecode v6
}

