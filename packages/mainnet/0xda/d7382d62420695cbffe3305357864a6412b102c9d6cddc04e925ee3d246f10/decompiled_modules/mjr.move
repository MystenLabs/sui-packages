module 0xdad7382d62420695cbffe3305357864a6412b102c9d6cddc04e925ee3d246f10::mjr {
    struct MJR has drop {
        dummy_field: bool,
    }

    fun init(arg0: MJR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MJR>(arg0, 9, b"MJR", b"MAJOR", b"major", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2867935d-4e0b-484f-bb94-0492138f15ef.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MJR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MJR>>(v1);
    }

    // decompiled from Move bytecode v6
}

