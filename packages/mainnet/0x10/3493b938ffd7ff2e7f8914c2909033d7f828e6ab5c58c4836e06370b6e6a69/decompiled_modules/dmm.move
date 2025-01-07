module 0x103493b938ffd7ff2e7f8914c2909033d7f828e6ab5c58c4836e06370b6e6a69::dmm {
    struct DMM has drop {
        dummy_field: bool,
    }

    fun init(arg0: DMM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DMM>(arg0, 9, b"DMM", x"c490c3b9206dc3a1206dc3a079", x"c490c3a279206cc3a02068c3a06e67207669e1bb8774206e616d206368e1baa574206cc6b0e1bba36e672063616f2c20c491c6b0e1bba3632074e1baa16f2074e1bbab206e68e1bbaf6e672063c3a169206dc3b56d2068e1bb976e206e68e1baa574207669e1bb8774206e616d2c20746f6b656e2074e1baa16f207261206368c6a16920767569206cc3a0206368c3ad6e68202c2063c3b3206769c3a1207472e1bb8b206cc3a0206dc6b0e1bb9d69", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/07526cda-9ada-4698-87e3-50b74242f809.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DMM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DMM>>(v1);
    }

    // decompiled from Move bytecode v6
}

