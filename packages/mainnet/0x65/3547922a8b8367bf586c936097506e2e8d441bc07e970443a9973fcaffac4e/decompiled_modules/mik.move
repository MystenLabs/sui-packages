module 0x653547922a8b8367bf586c936097506e2e8d441bc07e970443a9973fcaffac4e::mik {
    struct MIK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIK>(arg0, 9, b"MIK", b"MIKE", x"436f6d6d756e697479206973207468652062657374207574696c69747920f09f9a80", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/11521f7e-a6ca-49f2-b9a4-835a14752692.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MIK>>(v1);
    }

    // decompiled from Move bytecode v6
}

