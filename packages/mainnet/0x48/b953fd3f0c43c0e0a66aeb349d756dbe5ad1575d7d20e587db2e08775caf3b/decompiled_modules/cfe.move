module 0x48b953fd3f0c43c0e0a66aeb349d756dbe5ad1575d7d20e587db2e08775caf3b::cfe {
    struct CFE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CFE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CFE>(arg0, 9, b"CFE", b"Cafe", b"Token of the Coffee", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ec40074e-5bf5-4f2e-aa21-4dfe41f7a8e0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CFE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CFE>>(v1);
    }

    // decompiled from Move bytecode v6
}

