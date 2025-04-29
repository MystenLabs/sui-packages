module 0x7802fea7c3902227622b5cbb33386dbc973ce9bb2fd7c263475aa4294143f64f::gibli {
    struct GIBLI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIBLI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIBLI>(arg0, 9, b"GIBLI", b"a rpg on sui", b"in dev, soon on github", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/ecc6ee7d456c8bb4d323d00963f54482blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GIBLI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIBLI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

