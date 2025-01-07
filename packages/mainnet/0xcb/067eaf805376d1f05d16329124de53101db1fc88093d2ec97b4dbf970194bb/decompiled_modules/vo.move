module 0xcb067eaf805376d1f05d16329124de53101db1fc88093d2ec97b4dbf970194bb::vo {
    struct VO has drop {
        dummy_field: bool,
    }

    fun init(arg0: VO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VO>(arg0, 9, b"VO", b"Vo", b"So vo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/050c27a7-ea16-4b49-827d-92b09ce3f273.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VO>>(v1);
    }

    // decompiled from Move bytecode v6
}

