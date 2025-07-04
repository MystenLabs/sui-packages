module 0x8ba71c56a9ec536e8e44afe392ca947a07e87b829c20a9ea62f6d539a03080fe::backtowork {
    struct BACKTOWORK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BACKTOWORK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BACKTOWORK>(arg0, 9, b"BTW", b"backtowork", b"fries. bag. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/8703c704-6b39-4c92-902a-b59da7555c7a.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BACKTOWORK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BACKTOWORK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

