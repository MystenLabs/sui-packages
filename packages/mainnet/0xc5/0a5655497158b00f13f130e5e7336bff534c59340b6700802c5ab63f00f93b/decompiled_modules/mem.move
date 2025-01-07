module 0xc50a5655497158b00f13f130e5e7336bff534c59340b6700802c5ab63f00f93b::mem {
    struct MEM has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEM>(arg0, 9, b"MEM", b"EVENPUMP", b"We all believe in the sui ecosystem and its creator", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/32281e34-eed4-4642-8312-74e544cad5a3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEM>>(v1);
    }

    // decompiled from Move bytecode v6
}

