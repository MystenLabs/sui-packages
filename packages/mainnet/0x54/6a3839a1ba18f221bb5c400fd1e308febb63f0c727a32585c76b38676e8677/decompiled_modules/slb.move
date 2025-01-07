module 0x546a3839a1ba18f221bb5c400fd1e308febb63f0c727a32585c76b38676e8677::slb {
    struct SLB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLB>(arg0, 9, b"SLB", b"Slowbro", b"Slowwwwwww", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/95cea061-abe9-47a4-9f4d-025318c972bd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SLB>>(v1);
    }

    // decompiled from Move bytecode v6
}

