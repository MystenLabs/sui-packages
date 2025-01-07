module 0x259479e4af51907ba1321aa89090537bd4dcbe253ae0564d571a61a367535ddc::wheldragon {
    struct WHELDRAGON has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHELDRAGON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHELDRAGON>(arg0, 6, b"WhelDragon", b"WheelDragon", b"WheelDragon is here to carve a path of prosperity.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/qr8g253u_400x400_e9b2f87868.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHELDRAGON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WHELDRAGON>>(v1);
    }

    // decompiled from Move bytecode v6
}

