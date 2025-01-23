module 0xd805a1ccb8eb083198d5e480aceb6c720eb41ce4a415aa8a5470e9c753497527::nto {
    struct NTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NTO>(arg0, 6, b"NTO", b"New token", b"Test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://public-cdn.daossui.io/assets/tokens/f9fe9c10-d962-11ef-a74b-b3b817eed47e")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NTO>>(v1);
        0x2::coin::mint_and_transfer<NTO>(&mut v2, 1100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NTO>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

