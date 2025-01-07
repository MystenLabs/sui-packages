module 0x1f86b1b83852b2ffac5acdd0ca99bfc8ff114810da16a2234f6bb26d67972de2::kol {
    struct KOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOL>(arg0, 9, b"KOL", b"Kola", b"Kola token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/70c83ef8-bee2-4778-8dde-bae2a6dedfcb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

