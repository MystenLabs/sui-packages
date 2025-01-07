module 0x2c34d104c387e1cea4e74e6dcb8db7613834e06baffc5464ab4b92f6a0d8ce70::crazy {
    struct CRAZY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRAZY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRAZY>(arg0, 6, b"CRAZY", b"Crazy On Sui", b"Sometimes Sui network is crazy, from zero to a billion-dollar legend that no one knows.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BKE_Pd_Ow_M_400x400_8186677875.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRAZY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRAZY>>(v1);
    }

    // decompiled from Move bytecode v6
}

