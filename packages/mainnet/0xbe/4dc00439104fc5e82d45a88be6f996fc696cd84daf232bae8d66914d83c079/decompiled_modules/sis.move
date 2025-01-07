module 0xbe4dc00439104fc5e82d45a88be6f996fc696cd84daf232bae8d66914d83c079::sis {
    struct SIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIS>(arg0, 6, b"SIS", b"SuIguana Smoking", b"SuIguana Smoking is more than just a meme token, it's a religion. If you accept this religion, it is forever.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730977408569.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

