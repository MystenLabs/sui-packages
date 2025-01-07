module 0x779113c7c3746c7b96a9b84faa3376954983606e08710e331b335f4c20d299bd::obc {
    struct OBC has drop {
        dummy_field: bool,
    }

    fun init(arg0: OBC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OBC>(arg0, 9, b"OBC", b"OBACRYPTO", b"TRADING OF CRYPTOCURRENCY, BUYING AND SELLING OF BTC ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4ced368b-9533-4ca6-b3f8-87978511735d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OBC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OBC>>(v1);
    }

    // decompiled from Move bytecode v6
}

