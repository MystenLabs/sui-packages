module 0x7fb18d0d41dbb3fd3815f5ae8abdf379094a5c28c1c083959738f6bbb8c4afca::fatbuilder {
    struct FATBUILDER has drop {
        dummy_field: bool,
    }

    fun init(arg0: FATBUILDER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<FATBUILDER>(arg0, 6, b"FATBUILDER", b"Fat Builder by SuiAI", b"Fat Builder the Al agent that will help you to build onchain. The agent will help to provide information about web developing, web design, tools, and market interest!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/88da51af8d058e515441baffd912e1f7_high_df28e56d16.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FATBUILDER>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FATBUILDER>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

