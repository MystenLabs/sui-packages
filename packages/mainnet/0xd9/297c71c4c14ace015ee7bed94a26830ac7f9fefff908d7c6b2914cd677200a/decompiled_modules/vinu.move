module 0xd9297c71c4c14ace015ee7bed94a26830ac7f9fefff908d7c6b2914cd677200a::vinu {
    struct VINU has drop {
        dummy_field: bool,
    }

    fun init(arg0: VINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VINU>(arg0, 6, b"VINU", b"Vita Inu", x"4d616b652043727970746f20477265617420416761696e2057697468202456494e550a54686520576f726c642773204669727374204c696768742d537065656420446f6720436f696e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/vinu_827b3c1e20.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VINU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VINU>>(v1);
    }

    // decompiled from Move bytecode v6
}

