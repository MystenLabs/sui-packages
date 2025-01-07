module 0x5a493c7ac6c5e96ea4a806273357fd4080e179b86009bcc9cd533867e6df0744::paw {
    struct PAW has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAW>(arg0, 6, b"PAW", b"PawPaw", x"686f7020686f702c2067727272206772722c20776f6f6620776f6f660a24504157", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730999221595.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

