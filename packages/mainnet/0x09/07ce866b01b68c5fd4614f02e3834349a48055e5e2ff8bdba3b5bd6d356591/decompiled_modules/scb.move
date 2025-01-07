module 0x907ce866b01b68c5fd4614f02e3834349a48055e5e2ff8bdba3b5bd6d356591::scb {
    struct SCB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCB>(arg0, 6, b"SCB", b"SUI CHEESE BALL", b"SUI CHEESE BALL!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3_Ykn_F_Lui_400x400_22cf7f0773.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCB>>(v1);
    }

    // decompiled from Move bytecode v6
}

