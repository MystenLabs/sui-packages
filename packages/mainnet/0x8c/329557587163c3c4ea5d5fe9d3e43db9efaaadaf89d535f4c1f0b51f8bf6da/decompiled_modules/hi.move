module 0x8c329557587163c3c4ea5d5fe9d3e43db9efaaadaf89d535f4c1f0b51f8bf6da::hi {
    struct HI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HI>(arg0, 9, b"HI", b"Luan", b"Hiblo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/79420ab3-2483-4afb-b919-7a73abb5686b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HI>>(v1);
    }

    // decompiled from Move bytecode v6
}

