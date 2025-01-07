module 0xe9202b15b5ef76e94b44813fe48b8c2db1aeb3e747a45b93de10c8b992e0f857::pampi {
    struct PAMPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAMPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAMPI>(arg0, 9, b"PAMPI", b"Pampi", b"Inspried by Disney cartoon deer", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/92f376dd-a5ee-4c25-a4aa-a4ce4ba9af2f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAMPI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAMPI>>(v1);
    }

    // decompiled from Move bytecode v6
}

