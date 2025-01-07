module 0x65e3efdb94d2b5e226970d2c9d09a5bab6d60260ce4c5ff9664c34cae5790a2b::mtr {
    struct MTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: MTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MTR>(arg0, 6, b"MTR", b"metro", b"ground breaking token with a native value.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/O_Ct_Fk_Zbn_400x400_74f8d532d6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MTR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MTR>>(v1);
    }

    // decompiled from Move bytecode v6
}

