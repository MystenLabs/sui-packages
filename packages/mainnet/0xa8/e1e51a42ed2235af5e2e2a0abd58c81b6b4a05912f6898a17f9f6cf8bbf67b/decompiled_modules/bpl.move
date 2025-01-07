module 0xa8e1e51a42ed2235af5e2e2a0abd58c81b6b4a05912f6898a17f9f6cf8bbf67b::bpl {
    struct BPL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BPL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BPL>(arg0, 9, b"BPL", b"POLITE BOY", b"POLITE BOY . POLITE MEME COIN ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d8bdf463-b538-4cfb-948e-dc195a8401f2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BPL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BPL>>(v1);
    }

    // decompiled from Move bytecode v6
}

