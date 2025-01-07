module 0x2bacf56a486127171bc7a8a72c1472baf42e19d7d3ef118a604402e9eb9a21ab::bluber {
    struct BLUBER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUBER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUBER>(arg0, 6, b"BLUBER", b"SUI BLUBER", b"It's time to take over the sui ocean, brought to you by BLuber. $BLuber is ready to embark on his crypto journey, from Internet sensation to SUI immortality.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731171233831.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLUBER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUBER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

