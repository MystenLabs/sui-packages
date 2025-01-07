module 0x75ffc3f704872d697e1250bb1514e2d003b80e3cb869f3671621da5560cc6a62::unidog {
    struct UNIDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNIDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNIDOG>(arg0, 6, b"Unidog", b"UNI - SUI CEO's dog", b"UNI is the dog from Evan the SUI CEO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/uni_577b488034.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNIDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UNIDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

