module 0x97537811fdd3fd956a24080ab8fdc0cc5383bdf48b99dc16b02a993ed292d412::comemefi {
    struct COMEMEFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: COMEMEFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COMEMEFI>(arg0, 6, b"Comemefi", b"Memefi community", b"Memefi community ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000055614_0808f7f26c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COMEMEFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COMEMEFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

