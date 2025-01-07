module 0xf6d80370b4012d0019c3fb446b70e824029d93212268bf88f64b2737e33e40e7::pf {
    struct PF has drop {
        dummy_field: bool,
    }

    fun init(arg0: PF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PF>(arg0, 9, b"PF", b"POCKETFI", b"POCKETFI BOT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f648fd06-d3fa-4d5c-97d8-202fc7cffcd8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PF>>(v1);
    }

    // decompiled from Move bytecode v6
}

