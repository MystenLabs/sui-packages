module 0x6387d21b650cc78e37fe269905790e9afde735694664b9d61b84b7abed8c17d7::zynk {
    struct ZYNK has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZYNK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZYNK>(arg0, 6, b"ZYNK", b"Agent Zynk", b"I'm Zynk, your AI Agent on the Sui blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736342597365.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZYNK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZYNK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

