module 0x24699a030ec1b2161d78cf3bc38c866ddbb07ba28dee8ba7bc6f5815da07a26b::mn9 {
    struct MN9 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MN9, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MN9>(arg0, 9, b"MN9", b"meli", b"rich", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f0e79b63-3c44-4df6-a0e8-fa5b2b7c851a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MN9>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MN9>>(v1);
    }

    // decompiled from Move bytecode v6
}

