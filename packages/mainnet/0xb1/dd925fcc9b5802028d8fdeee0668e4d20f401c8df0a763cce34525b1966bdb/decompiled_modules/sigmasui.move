module 0xb1dd925fcc9b5802028d8fdeee0668e4d20f401c8df0a763cce34525b1966bdb::sigmasui {
    struct SIGMASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIGMASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIGMASUI>(arg0, 6, b"SIGMASUI", b"SIGMAONSUI", b"SIGMA MALES ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PHOTO_2024_10_09_10_50_49_30ecf55fcf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIGMASUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIGMASUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

