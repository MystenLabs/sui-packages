module 0x6137c221fd9362fa258088c17e581e62fea44cfb3bdf054464c964affb3e137::mostofa769 {
    struct MOSTOFA769 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOSTOFA769, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOSTOFA769>(arg0, 9, b"MOSTOFA769", b"Mostofa Ka", x"53696d706c6520626f7920f09f9889", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ee41c075-79fc-4e77-a729-ba5b8a7e2f4f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOSTOFA769>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOSTOFA769>>(v1);
    }

    // decompiled from Move bytecode v6
}

