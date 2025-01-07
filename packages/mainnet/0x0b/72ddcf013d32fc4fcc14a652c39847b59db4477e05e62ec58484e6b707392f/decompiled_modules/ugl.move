module 0xb72ddcf013d32fc4fcc14a652c39847b59db4477e05e62ec58484e6b707392f::ugl {
    struct UGL has drop {
        dummy_field: bool,
    }

    fun init(arg0: UGL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UGL>(arg0, 6, b"Ugl", b"Ugly", b"this is only the more ugly fish, buy this ugly fish, make money ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731016743729.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UGL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UGL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

