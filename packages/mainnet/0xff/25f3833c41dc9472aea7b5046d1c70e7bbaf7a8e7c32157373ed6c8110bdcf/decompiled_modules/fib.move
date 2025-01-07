module 0xff25f3833c41dc9472aea7b5046d1c70e7bbaf7a8e7c32157373ed6c8110bdcf::fib {
    struct FIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIB>(arg0, 9, b"FIB", b"nerve fibe", b"glowing nerve fibers", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3f72d1be-b3c3-4c4c-87f2-73bdb82408e7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FIB>>(v1);
    }

    // decompiled from Move bytecode v6
}

