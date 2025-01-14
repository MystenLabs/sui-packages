module 0x7486d0f1ca44affff4eb56e4f37a238a49ef2c94246d34a831119944b3271040::gaixbt {
    struct GAIXBT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAIXBT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<GAIXBT>(arg0, 6, b"GAIXBT", b"grabAIXBT by SuiAI", b"grabAIXBT will posting for information whales wallet for their tx", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/image_1736847812401721_2b348987d5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GAIXBT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAIXBT>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

