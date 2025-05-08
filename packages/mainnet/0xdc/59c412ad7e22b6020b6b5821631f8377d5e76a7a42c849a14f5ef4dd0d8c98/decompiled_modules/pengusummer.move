module 0xdc59c412ad7e22b6020b6b5821631f8377d5e76a7a42c849a14f5ef4dd0d8c98::pengusummer {
    struct PENGUSUMMER has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENGUSUMMER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENGUSUMMER>(arg0, 6, b"PENGUSUMMER", b"PenguSummer", b"Are you shape for penguSummer?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20250509_020541_ad353e008b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENGUSUMMER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PENGUSUMMER>>(v1);
    }

    // decompiled from Move bytecode v6
}

