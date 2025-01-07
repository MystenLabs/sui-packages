module 0x872339c2156a94b4abec1f428d6ab1e7b6afa468bc2d75a854a4c4bf53b6f50e::pawpaw {
    struct PAWPAW has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWPAW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAWPAW>(arg0, 6, b"PawPaw", b"PawPaw ", x"686f7020686f702c2067727272206772722c20776f6f6620776f6f660a24504157", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730955852606.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAWPAW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAWPAW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

