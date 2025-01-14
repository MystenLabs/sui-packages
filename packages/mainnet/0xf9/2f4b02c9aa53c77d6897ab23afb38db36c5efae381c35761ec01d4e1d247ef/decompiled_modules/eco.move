module 0xf92f4b02c9aa53c77d6897ab23afb38db36c5efae381c35761ec01d4e1d247ef::eco {
    struct ECO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ECO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ECO>(arg0, 6, b"ECO", b"Eco AI by SuiAI", b"EcoAI drives sustainable development through its ecosystem composed of four AI agents. In the innovation phase, the AI Agent Builder allows users to create or deploy diverse agents. The X AI Agent spreads the concept of sustainability across social platforms, the TG AI Agent keeps the Telegram community informed, and the AI X Army is under development. As the project progresses, the generated revenue will be reinvested in initiatives such as tree - planting and ecological restoration. EcoAI is committed to building a self - improving AI cluster. The EcoAI token facilitates the realization of innovation and sustainable development within this ecosystem, propelling the construction of a better green world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/7_CW_Ofs_EG_400x400_65f1af9d51.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ECO>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ECO>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

