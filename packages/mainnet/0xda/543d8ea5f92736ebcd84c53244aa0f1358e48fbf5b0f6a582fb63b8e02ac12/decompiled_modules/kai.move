module 0xda543d8ea5f92736ebcd84c53244aa0f1358e48fbf5b0f6a582fb63b8e02ac12::kai {
    struct KAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAI>(arg0, 6, b"KAI", b"KAI The KOI AI", b"Koi fish have different meanings in different cultures, but they generally symbolize good fortune, perseverance, and success", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733675569507.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

