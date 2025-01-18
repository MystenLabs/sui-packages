module 0x1f32c77f30df7b5a6c7a4290b427e43826310c1803f7a81fa6b97c50743366ac::ivy {
    struct IVY has drop {
        dummy_field: bool,
    }

    fun init(arg0: IVY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<IVY>(arg0, 6, b"IVY", b"ivy by SuiAI", b"sexy, smart and intelligent girl that knows deeply about crypto", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Screenshot_2025_01_17_at_9_23_26_PM_3e6df16ddc.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<IVY>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IVY>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

