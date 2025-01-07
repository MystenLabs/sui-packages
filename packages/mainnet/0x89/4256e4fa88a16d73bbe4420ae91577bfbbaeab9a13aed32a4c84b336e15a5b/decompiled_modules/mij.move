module 0x894256e4fa88a16d73bbe4420ae91577bfbbaeab9a13aed32a4c84b336e15a5b::mij {
    struct MIJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIJ>(arg0, 9, b"MIJ", b"MiliJoy", b"From mili-joy to million joy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0950b00d-af66-44d2-bcb3-5836b74e8455.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MIJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

