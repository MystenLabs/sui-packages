module 0x54fd6a0087f5fbd15f758290829a126ce716cfad262ecfcc6e55d53462e87c1::mk {
    struct MK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MK>(arg0, 9, b"MK", b"Msnish", b"Crypto", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d2050119-c2c2-429d-99af-ec123a2ed3b2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MK>>(v1);
    }

    // decompiled from Move bytecode v6
}

