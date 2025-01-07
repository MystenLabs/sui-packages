module 0x3f7e63d7a4b3d91b1a399f4cef55c5b91acd199a5224b8ab053b83ca4dedb41c::dmaga {
    struct DMAGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DMAGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DMAGA>(arg0, 9, b"DMAGA", b"Dark Maga ", b"Dark Maga on Sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/60526009-fff5-4ebb-b16b-dede4b982d56.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DMAGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DMAGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

