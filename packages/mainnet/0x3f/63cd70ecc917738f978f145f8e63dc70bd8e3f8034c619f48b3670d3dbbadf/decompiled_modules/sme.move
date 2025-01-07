module 0x3f63cd70ecc917738f978f145f8e63dc70bd8e3f8034c619f48b3670d3dbbadf::sme {
    struct SME has drop {
        dummy_field: bool,
    }

    fun init(arg0: SME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SME>(arg0, 9, b"SME", b"Suimeme", b"Currencies transfer among countries with the aid of cryptocurrency.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bc1e71fc-faa9-4e15-91b9-a166ad17773a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SME>>(v1);
    }

    // decompiled from Move bytecode v6
}

