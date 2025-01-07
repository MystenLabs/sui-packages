module 0x9dba52b3b92e3fa8e8adf4cdef50d1d22cfff48afb41314d20ceffa2138cc0d0::sye {
    struct SYE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SYE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SYE>(arg0, 9, b"SYE", b"saayee", b"saayee means shadow!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/735e8bd8-f99d-4bb1-8cc2-a220f7ef0ed6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SYE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SYE>>(v1);
    }

    // decompiled from Move bytecode v6
}

