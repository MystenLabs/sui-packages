module 0xd2821550c849f061f4e15f19a7a69f89e282a4548b86b78fafe6b95b6011738c::comcom {
    struct COMCOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: COMCOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COMCOM>(arg0, 9, b"COMCOM", b"MrTrade", b"Win and win", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f4c2b576-5228-47c8-9dd5-b84961555d82.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COMCOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COMCOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

