module 0xbc7d96609c26c288a8dc5498e6e23f0998e8c6b4105115ca15c471f1fc8970e5::wabisabi {
    struct WABISABI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WABISABI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WABISABI>(arg0, 6, b"WABISABI", b"WABI SABI BY ELON", b"Wabi Sabi by Elon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/wabisabi_1cd8fd90dd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WABISABI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WABISABI>>(v1);
    }

    // decompiled from Move bytecode v6
}

