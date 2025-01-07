module 0xb53fb604e47f38597ebe177b4df5083d062ac6357f963a6c472c042efec32c98::vna {
    struct VNA has drop {
        dummy_field: bool,
    }

    fun init(arg0: VNA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VNA>(arg0, 9, b"VNA", b"Vana", b"Vana list on binance 30dec", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/046e4e11-985d-4065-bd43-7a30c625304b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VNA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VNA>>(v1);
    }

    // decompiled from Move bytecode v6
}

