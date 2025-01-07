module 0xfadd5e68716da24598a07af7a323274ce59c34ed61081571bf0f2cfca3abc42f::dgb {
    struct DGB has drop {
        dummy_field: bool,
    }

    fun init(arg0: DGB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DGB>(arg0, 9, b"DGB", b"DragonBall", b"An ancient Chinese dragon a symbol of wealth and gold.. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0ba21785-3a1e-4a18-92bd-d10e773d622f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DGB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DGB>>(v1);
    }

    // decompiled from Move bytecode v6
}

