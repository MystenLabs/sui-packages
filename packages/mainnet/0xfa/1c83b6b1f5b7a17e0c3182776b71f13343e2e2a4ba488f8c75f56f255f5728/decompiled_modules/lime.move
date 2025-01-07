module 0xfa1c83b6b1f5b7a17e0c3182776b71f13343e2e2a4ba488f8c75f56f255f5728::lime {
    struct LIME has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIME>(arg0, 9, b"LIME", b"Limecoin", x"486920666f6c6b732120496620796f75206c696b65206c696d657320616e64206d656d65636f696e732c207468697320746f6b656e206973206a75737420666f7220796f752120446f6e2774206d697373206f757421f09fa491", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2ae4acc2-5fe5-4fbf-8a4e-3851e36c5f96.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LIME>>(v1);
    }

    // decompiled from Move bytecode v6
}

