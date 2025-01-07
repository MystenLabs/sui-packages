module 0xd7be8fd1df674deb57a88e330b1a091587298c270569d902382f559962eb9564::snrb {
    struct SNRB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNRB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNRB>(arg0, 9, b"SNRB", b"Snow Rabit", b"Rabit in the Snow", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/44783d69-2897-494e-b9cb-d425de96687c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNRB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SNRB>>(v1);
    }

    // decompiled from Move bytecode v6
}

