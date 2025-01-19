module 0xf83767b3b06254b9be78a647dbcc1da11a471178477eba2dc81b8f87ee31313b::subu {
    struct SUBU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUBU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUBU>(arg0, 9, b"SUBU", b"Suibuilder", b"Help to grow sui community ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/32bee60b-1b04-4b2f-aa13-d4f2bedd5da9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUBU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUBU>>(v1);
    }

    // decompiled from Move bytecode v6
}

