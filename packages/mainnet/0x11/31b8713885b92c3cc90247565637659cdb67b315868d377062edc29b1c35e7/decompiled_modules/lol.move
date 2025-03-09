module 0x1131b8713885b92c3cc90247565637659cdb67b315868d377062edc29b1c35e7::lol {
    struct LOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOL>(arg0, 9, b"LOL", b"LolCoin", b" For literal laughs out loud.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/a4ea18562fc2134d60f070d09576f80bblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

