module 0x44585e031dbf891982925cf5863de3d94d7e945cded05b5a6e5ed699236873d8::hopdoge {
    struct HOPDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPDOGE>(arg0, 6, b"HOPDOGE", b"HOPDOGE TOKEN", x"466972737420646f67206f6e20687474703a2f2f686f702e66756e20f09f90b6", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731014345593.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOPDOGE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPDOGE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

