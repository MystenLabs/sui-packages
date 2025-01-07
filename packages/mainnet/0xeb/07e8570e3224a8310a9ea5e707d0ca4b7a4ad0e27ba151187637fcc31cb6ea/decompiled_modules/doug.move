module 0xeb07e8570e3224a8310a9ea5e707d0ca4b7a4ad0e27ba151187637fcc31cb6ea::doug {
    struct DOUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOUG>(arg0, 6, b"DOUG", b"DOUG THE PUG", b"Doug the Pug is a pug living in Nashville", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/w8qx_F6_Sl_400x400_b53c9233d9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

