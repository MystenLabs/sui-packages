module 0x432c9b7a25ff881ddd26d20fa104c11dffc6dfa48b5406683dfda63b13716a6::This_Bs {
    struct THIS_BS has drop {
        dummy_field: bool,
    }

    fun init(arg0: THIS_BS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THIS_BS>(arg0, 9, b"90DBS", b"This Bs", b"girls be making us wait 90 days for this bs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/GzS3pM8XIAAgNuK?format=jpg&name=medium")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<THIS_BS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THIS_BS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

