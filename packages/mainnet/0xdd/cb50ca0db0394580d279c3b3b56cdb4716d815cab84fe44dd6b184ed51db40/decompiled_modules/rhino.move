module 0xddcb50ca0db0394580d279c3b3b56cdb4716d815cab84fe44dd6b184ed51db40::rhino {
    struct RHINO has drop {
        dummy_field: bool,
    }

    fun init(arg0: RHINO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RHINO>(arg0, 6, b"RHINO", b"Diamond Rhino", b"Introducing $RHINO: The coin with a purpose! Aiming to raise awareness and help protect the declining population of rhinos.  Join us in making a difference!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1huu5o_w_400x400_4d14aa91be.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RHINO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RHINO>>(v1);
    }

    // decompiled from Move bytecode v6
}

