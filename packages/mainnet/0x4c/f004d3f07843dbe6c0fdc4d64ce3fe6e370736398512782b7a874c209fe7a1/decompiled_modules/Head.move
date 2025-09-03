module 0x4cf004d3f07843dbe6c0fdc4d64ce3fe6e370736398512782b7a874c209fe7a1::Head {
    struct HEAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEAD>(arg0, 9, b"HEAD", b"Head", b"Big head", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.pinimg.com/736x/05/ae/40/05ae406b88cd64c36f6e7e7f021dbf0f.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HEAD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEAD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

