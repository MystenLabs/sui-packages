module 0x38c5ff9a026a2889248da5d07b2dc74c48088e81af141404c8a9a57fbb348d67::tony {
    struct TONY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TONY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TONY>(arg0, 6, b"Tony", b"Tony Suiprano", b"The chaddest man in the chaddest sea", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/17280579852803_b8c22840a4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TONY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TONY>>(v1);
    }

    // decompiled from Move bytecode v6
}

