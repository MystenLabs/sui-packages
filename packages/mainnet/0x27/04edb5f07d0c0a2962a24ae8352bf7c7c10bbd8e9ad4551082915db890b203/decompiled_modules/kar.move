module 0x2704edb5f07d0c0a2962a24ae8352bf7c7c10bbd8e9ad4551082915db890b203::kar {
    struct KAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAR>(arg0, 9, b"Kar", b"white", b"....", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/bf85c5e24c7965484acdf80b0c4e7e5bblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KAR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

