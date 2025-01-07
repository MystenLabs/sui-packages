module 0x34c4631322459ee393136d67cdc76d5b014e0ac82147b66c15726b76104809cf::srose {
    struct SROSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SROSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SROSE>(arg0, 6, b"SROSE", b"Sui Rose", b"First Rose on Sui: https://www.rosecoinonsui.xyz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_17_c7541a9dff.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SROSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SROSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

