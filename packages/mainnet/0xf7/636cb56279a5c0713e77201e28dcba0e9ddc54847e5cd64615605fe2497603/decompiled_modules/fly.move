module 0xf7636cb56279a5c0713e77201e28dcba0e9ddc54847e5cd64615605fe2497603::fly {
    struct FLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLY>(arg0, 9, b"FLY", b"fly", x"54686520736f6172696e672063727970746f63757272656e63792074686174277320656c65766174696e6720796f757220706f7274666f6c696f20746f206e657720686569676874732c2064656c69766572696e6720686967682d666c79696e672070726f6669747320616e6420612073656e7365206f6620616476656e7475726520e29c88efb88f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c8f462a2-e5c4-4304-8fb2-ae5334b2b857.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

