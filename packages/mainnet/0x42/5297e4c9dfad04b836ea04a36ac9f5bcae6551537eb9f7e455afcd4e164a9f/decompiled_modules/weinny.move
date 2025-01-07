module 0x425297e4c9dfad04b836ea04a36ac9f5bcae6551537eb9f7e455afcd4e164a9f::weinny {
    struct WEINNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEINNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEINNY>(arg0, 6, b"WEINNY", b"$WEINNY", x"245745494e4e592069732061206d656d6520696e73706972656420627920746865207765696e657220646f6773203a206c61756e6368696e67206f6e200a405375694e6574776f726b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Omj_O_Vh_D7_400x400_c54b5c71bf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEINNY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WEINNY>>(v1);
    }

    // decompiled from Move bytecode v6
}

