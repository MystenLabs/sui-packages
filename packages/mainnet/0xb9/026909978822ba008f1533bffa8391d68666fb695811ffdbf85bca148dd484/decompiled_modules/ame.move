module 0xb9026909978822ba008f1533bffa8391d68666fb695811ffdbf85bca148dd484::ame {
    struct AME has drop {
        dummy_field: bool,
    }

    fun init(arg0: AME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AME>(arg0, 9, b"AME", b"AMEN", b"Spiritual ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fdae1c1f-1439-4355-96b1-182733dfab08.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AME>>(v1);
    }

    // decompiled from Move bytecode v6
}

