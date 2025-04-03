module 0x58d33d61af982bf0b7ad3794cc3e8b6e66fcb1fbc20542d303fbc8dbf3f3c1fb::kam {
    struct KAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAM>(arg0, 9, b"KAM", b"KAMMY", b"KAMMY is a lovely, lovable soul, cute smile, spicy attitude and the lady after my heart", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/4cd2e4b09972913baa7a7b3bdab2d551blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KAM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

