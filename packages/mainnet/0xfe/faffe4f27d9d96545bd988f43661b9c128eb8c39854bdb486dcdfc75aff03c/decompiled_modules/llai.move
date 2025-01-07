module 0xfefaffe4f27d9d96545bd988f43661b9c128eb8c39854bdb486dcdfc75aff03c::llai {
    struct LLAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LLAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LLAI>(arg0, 6, b"Llai", b"LuluAI", b"Hi i m Lulu just a simple ai girl", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732987694366.jfif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LLAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LLAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

