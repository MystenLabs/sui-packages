module 0x65285fb623193098af3e46a34d4ef484c0368937bacb3c2f81bc7e1cddb19f33::arenaa {
    struct ARENAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARENAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARENAA>(arg0, 9, b"ARENAA", b"Arena", b"Arena on wave", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2c50143f-b718-4b1c-80b3-96d7d0303561.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARENAA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ARENAA>>(v1);
    }

    // decompiled from Move bytecode v6
}

