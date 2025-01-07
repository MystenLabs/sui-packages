module 0x29425aff311996485d2418bb80ede3bcdfe5043eed9df654a0ac02bcf373ba6f::goats {
    struct GOATS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOATS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOATS>(arg0, 6, b"GOATS", b"GOAT on SUI", b"Ignore the fud, enjoy the waves", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/n_Jjl_Kt_WD_400x400_acc0a34b39.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOATS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOATS>>(v1);
    }

    // decompiled from Move bytecode v6
}

