module 0xfc84a76eeab662e5a9b85ae8cbd8f4fc587e73495bccf94d12275a815283c931::gen {
    struct GEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GEN>(arg0, 9, b"GEN", b"Tokenomic", b"Tokenomic Generation Event", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/684d281c-8538-4531-8215-3bda2f2ef28a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

