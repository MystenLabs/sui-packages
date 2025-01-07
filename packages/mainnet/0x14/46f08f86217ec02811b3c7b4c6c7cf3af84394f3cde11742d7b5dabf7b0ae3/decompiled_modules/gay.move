module 0x1446f08f86217ec02811b3c7b4c6c7cf3af84394f3cde11742d7b5dabf7b0ae3::gay {
    struct GAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAY>(arg0, 6, b"GAY", b"gay shit", b"gayyyy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730950309800.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GAY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

