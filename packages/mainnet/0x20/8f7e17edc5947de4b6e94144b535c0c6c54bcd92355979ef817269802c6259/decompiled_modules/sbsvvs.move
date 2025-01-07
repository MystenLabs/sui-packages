module 0x208f7e17edc5947de4b6e94144b535c0c6c54bcd92355979ef817269802c6259::sbsvvs {
    struct SBSVVS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBSVVS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBSVVS>(arg0, 9, b"SBSVVS", b"Ababbs", b"Shsvvs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cb638e72-c072-4c34-995b-8693544da3f9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBSVVS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SBSVVS>>(v1);
    }

    // decompiled from Move bytecode v6
}

