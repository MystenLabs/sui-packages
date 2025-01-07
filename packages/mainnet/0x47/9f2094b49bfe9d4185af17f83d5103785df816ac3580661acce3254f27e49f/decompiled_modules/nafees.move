module 0x479f2094b49bfe9d4185af17f83d5103785df816ac3580661acce3254f27e49f::nafees {
    struct NAFEES has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAFEES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAFEES>(arg0, 9, b"NAFEES", b"NFS", b"Nafees MEME Cion", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/450b64cc-6123-4d10-8cf5-0b4e5393c1b3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAFEES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NAFEES>>(v1);
    }

    // decompiled from Move bytecode v6
}

