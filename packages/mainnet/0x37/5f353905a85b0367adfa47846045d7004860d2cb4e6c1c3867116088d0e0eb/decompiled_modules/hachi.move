module 0x375f353905a85b0367adfa47846045d7004860d2cb4e6c1c3867116088d0e0eb::hachi {
    struct HACHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HACHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HACHI>(arg0, 9, b"HACHI", b"Hachiware", b"Character comics created by Japanese cartoonist Nagano", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8659da07-bd42-43c3-9069-a2a2ca06f1e8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HACHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HACHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

