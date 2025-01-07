module 0xb7759719985e9869e09b08576be5819f6f8cbba1383cd806d72c9fbba7b7830f::pengy {
    struct PENGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENGY>(arg0, 6, b"PENGY", b"SUI PENGY", b"The most lovable penguin on  SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_74b261f4ea.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PENGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

