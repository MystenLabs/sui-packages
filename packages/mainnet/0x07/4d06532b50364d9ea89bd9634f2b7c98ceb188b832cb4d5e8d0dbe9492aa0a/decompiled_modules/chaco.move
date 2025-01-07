module 0x74d06532b50364d9ea89bd9634f2b7c98ceb188b832cb4d5e8d0dbe9492aa0a::chaco {
    struct CHACO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHACO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHACO>(arg0, 9, b"CHACO", b"chaco", b"CHACOAa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/157bc746-79a4-45d0-8c8d-23decb577aee.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHACO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHACO>>(v1);
    }

    // decompiled from Move bytecode v6
}

