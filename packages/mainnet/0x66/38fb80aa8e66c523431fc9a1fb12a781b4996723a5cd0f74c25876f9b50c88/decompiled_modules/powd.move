module 0x6638fb80aa8e66c523431fc9a1fb12a781b4996723a5cd0f74c25876f9b50c88::powd {
    struct POWD has drop {
        dummy_field: bool,
    }

    fun init(arg0: POWD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POWD>(arg0, 6, b"POWD", b"SUI POWD", b"$POWD. The most memeable memecoin in existence....", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/POWD_69fea93ce7.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POWD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POWD>>(v1);
    }

    // decompiled from Move bytecode v6
}

