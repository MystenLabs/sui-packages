module 0xae765c377959c1ea02392d548990264c2265d9da190b95869573cb979fa154b6::owbe {
    struct OWBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: OWBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OWBE>(arg0, 9, b"OWBE", b"bdjd", b"bdbd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8c34d984-66f7-4509-bd17-53d146c0758f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OWBE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OWBE>>(v1);
    }

    // decompiled from Move bytecode v6
}

