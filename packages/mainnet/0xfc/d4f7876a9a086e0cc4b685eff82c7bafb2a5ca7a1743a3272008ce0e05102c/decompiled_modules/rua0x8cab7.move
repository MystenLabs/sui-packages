module 0xfcd4f7876a9a086e0cc4b685eff82c7bafb2a5ca7a1743a3272008ce0e05102c::rua0x8cab7 {
    struct RUA0X8CAB7 has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUA0X8CAB7, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUA0X8CAB7>(arg0, 9, b"RUA0X8CAB7", b"RUA", b"This coin is very valuable in the future", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/18fb256e-ba4f-407d-9963-7da26099cd8d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUA0X8CAB7>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RUA0X8CAB7>>(v1);
    }

    // decompiled from Move bytecode v6
}

