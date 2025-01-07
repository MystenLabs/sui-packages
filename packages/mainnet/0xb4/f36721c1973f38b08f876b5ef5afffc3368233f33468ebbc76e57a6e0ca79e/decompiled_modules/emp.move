module 0xb4f36721c1973f38b08f876b5ef5afffc3368233f33468ebbc76e57a6e0ca79e::emp {
    struct EMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: EMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EMP>(arg0, 9, b"EMP", b"EMPOWER", b"Empower is a revolutionary cryptocurrency designed to empower tech startups and innovators. By facilitating investments and collaborations, Empower fuels groundbreaking ideas while offering users unique rewards and access to cutting-edge technologies.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d6e3ae5b-596e-48d7-aca1-dbff230c6a50.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

