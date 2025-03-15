module 0x2f0227fc8a4dbf9d97a3b34592050119a4b806f46225c9a6c90997fa9cbf2177::ko {
    struct KO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KO>(arg0, 9, b"KO", b"dodo", b"hai", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/0da1498e971619ea34e6093bbfc3db70blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

