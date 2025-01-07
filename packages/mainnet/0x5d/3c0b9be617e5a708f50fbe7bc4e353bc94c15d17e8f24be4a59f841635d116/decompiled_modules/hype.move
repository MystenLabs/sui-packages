module 0x5d3c0b9be617e5a708f50fbe7bc4e353bc94c15d17e8f24be4a59f841635d116::hype {
    struct HYPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HYPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HYPE>(arg0, 9, b"HYPE", b"HypeCoin", b"\"HypeCoin\" is a token that seeks to capture the energy of social media trends and hype. With a simple and striking name, HYPE focuses on an active community that loves to share and promote the token.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b1faadd9-607f-4822-b7fb-ef07a3355738.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HYPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HYPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

