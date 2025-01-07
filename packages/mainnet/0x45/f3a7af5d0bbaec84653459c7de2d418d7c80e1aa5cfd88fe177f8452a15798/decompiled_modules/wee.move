module 0x45f3a7af5d0bbaec84653459c7de2d418d7c80e1aa5cfd88fe177f8452a15798::wee {
    struct WEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEE>(arg0, 6, b"WEE", b"weee", b"weeee....", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732485253198.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

