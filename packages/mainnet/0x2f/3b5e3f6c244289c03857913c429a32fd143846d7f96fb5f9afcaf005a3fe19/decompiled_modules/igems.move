module 0x2f3b5e3f6c244289c03857913c429a32fd143846d7f96fb5f9afcaf005a3fe19::igems {
    struct IGEMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: IGEMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IGEMS>(arg0, 9, b"I-GEMS", b"INFUSED-GEMS", b"Krafted 1:1 pro-rata to `X`-SUI LP tokens burned via INFUSE FURNACE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://degenhive.ai/assets/igems_logo.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IGEMS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IGEMS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

