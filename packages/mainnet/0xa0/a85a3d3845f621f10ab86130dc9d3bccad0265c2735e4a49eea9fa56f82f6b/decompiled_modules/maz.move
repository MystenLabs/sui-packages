module 0xa0a85a3d3845f621f10ab86130dc9d3bccad0265c2735e4a49eea9fa56f82f6b::maz {
    struct MAZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAZ>(arg0, 9, b"MAZ", b"Mazoname", b"Meme 2024 to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9eafc330-e40b-4e75-b975-dc8dfa2a9fed.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

