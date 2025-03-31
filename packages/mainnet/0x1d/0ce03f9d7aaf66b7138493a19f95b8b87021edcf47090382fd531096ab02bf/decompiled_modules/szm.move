module 0x1d0ce03f9d7aaf66b7138493a19f95b8b87021edcf47090382fd531096ab02bf::szm {
    struct SZM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SZM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SZM>(arg0, 9, b"SZM", b"suzom", b"BUYY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/3f254da02a186e612cb9f0c574f2332ablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SZM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SZM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

