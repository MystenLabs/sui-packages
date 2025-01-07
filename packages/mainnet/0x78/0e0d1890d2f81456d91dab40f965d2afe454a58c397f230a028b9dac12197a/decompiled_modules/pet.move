module 0x780e0d1890d2f81456d91dab40f965d2afe454a58c397f230a028b9dac12197a::pet {
    struct PET has drop {
        dummy_field: bool,
    }

    fun init(arg0: PET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PET>(arg0, 9, b"PET", b"Peter ", b"Mystery in miracles ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ce1c1289-1545-4bd3-9376-2cf964ca9533.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PET>>(v1);
    }

    // decompiled from Move bytecode v6
}

