module 0xecaf660af8f8df1e9548aba0e80f5c0b514a8494ffe94f300312939fb1897835::biscuits {
    struct BISCUITS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BISCUITS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BISCUITS>(arg0, 6, b"Biscuits", b"Biscuits The Seal on SUI", b"Biscuits The Seal on SUI where we belong!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000046566_48855a5606.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BISCUITS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BISCUITS>>(v1);
    }

    // decompiled from Move bytecode v6
}

