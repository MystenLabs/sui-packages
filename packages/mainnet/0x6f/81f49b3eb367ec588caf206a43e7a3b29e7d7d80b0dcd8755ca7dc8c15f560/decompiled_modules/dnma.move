module 0x6f81f49b3eb367ec588caf206a43e7a3b29e7d7d80b0dcd8755ca7dc8c15f560::dnma {
    struct DNMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DNMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DNMA>(arg0, 9, b"DNMA", b"DINMA", b"JUST PERSONAL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fbcba482-ce88-484d-ba1d-a9f35021d36a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DNMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DNMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

