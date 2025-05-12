module 0x7e19ae3948c1daa7715bac1b13406261e67e310f056eee1b51272a0a36332e53::krtms {
    struct KRTMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRTMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRTMS>(arg0, 9, b"KRTMS", b"krtomas", b"ha ha ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/f231f322ef02f3c5e2fec39d1ed96c86blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KRTMS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRTMS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

