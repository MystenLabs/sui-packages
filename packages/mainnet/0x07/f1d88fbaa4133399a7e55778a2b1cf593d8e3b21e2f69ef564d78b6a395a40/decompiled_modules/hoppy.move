module 0x7f1d88fbaa4133399a7e55778a2b1cf593d8e3b21e2f69ef564d78b6a395a40::hoppy {
    struct HOPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPPY>(arg0, 6, b"HOPPY", b"HoppyOnSui", b"Dance with $Hoppy and forget all your worries", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000037288_4dc9277f94.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

