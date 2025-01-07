module 0x602defa87aca9553a435b314f66510933d881c59485452f5a716ad7b854a20ea::rdog {
    struct RDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: RDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RDOG>(arg0, 6, b"RDOG", b"First Royal Dog On Sui ( Real )", b"First Royal Dog On Sui .", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dogsui_769e1991f6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

