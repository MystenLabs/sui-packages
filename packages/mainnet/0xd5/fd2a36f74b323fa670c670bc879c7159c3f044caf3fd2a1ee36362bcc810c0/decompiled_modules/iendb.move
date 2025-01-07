module 0xd5fd2a36f74b323fa670c670bc879c7159c3f044caf3fd2a1ee36362bcc810c0::iendb {
    struct IENDB has drop {
        dummy_field: bool,
    }

    fun init(arg0: IENDB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IENDB>(arg0, 9, b"IENDB", b"bsjdnd", b"bdbd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5b9121f4-98ac-4bad-8675-d3f77fe3f629.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IENDB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IENDB>>(v1);
    }

    // decompiled from Move bytecode v6
}

