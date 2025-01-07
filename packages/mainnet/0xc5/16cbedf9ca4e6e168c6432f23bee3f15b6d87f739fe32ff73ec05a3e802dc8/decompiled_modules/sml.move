module 0xc516cbedf9ca4e6e168c6432f23bee3f15b6d87f739fe32ff73ec05a3e802dc8::sml {
    struct SML has drop {
        dummy_field: bool,
    }

    fun init(arg0: SML, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SML>(arg0, 9, b"SML", b"Small mush", b"Small mushroom", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e5289651-e2e0-4ad9-a710-53d5c6dc911b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SML>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SML>>(v1);
    }

    // decompiled from Move bytecode v6
}

