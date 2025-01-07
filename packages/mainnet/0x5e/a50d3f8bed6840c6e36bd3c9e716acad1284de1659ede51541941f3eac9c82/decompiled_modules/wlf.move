module 0x5ea50d3f8bed6840c6e36bd3c9e716acad1284de1659ede51541941f3eac9c82::wlf {
    struct WLF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WLF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WLF>(arg0, 9, b"WLF", b"wolf", x"556e6c6561736820796f757220706f74656e7469616cf09f90baf09f90baf09f90baf09f90ba", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0bdf0e3d-5caa-452a-95a3-11530157afab.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WLF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WLF>>(v1);
    }

    // decompiled from Move bytecode v6
}

