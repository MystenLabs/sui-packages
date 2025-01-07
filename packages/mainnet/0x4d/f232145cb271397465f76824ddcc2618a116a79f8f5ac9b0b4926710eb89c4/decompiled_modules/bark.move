module 0x4df232145cb271397465f76824ddcc2618a116a79f8f5ac9b0b4926710eb89c4::bark {
    struct BARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BARK>(arg0, 6, b"BARK", b"Official Barkingdog On Sui", b"Endless barks: once it starts, theres no turning back : barkingdogonsui.xyz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4_1_ad2af0a28b.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BARK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BARK>>(v1);
    }

    // decompiled from Move bytecode v6
}

