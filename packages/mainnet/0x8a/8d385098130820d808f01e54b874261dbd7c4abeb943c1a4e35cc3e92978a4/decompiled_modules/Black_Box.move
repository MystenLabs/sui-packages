module 0x8a8d385098130820d808f01e54b874261dbd7c4abeb943c1a4e35cc3e92978a4::Black_Box {
    struct BLACK_BOX has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLACK_BOX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLACK_BOX>(arg0, 9, b"BB", b"Black Box", b"what's inside?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/c8a64694-6208-4098-982a-35c9d4c6c847.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLACK_BOX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLACK_BOX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

