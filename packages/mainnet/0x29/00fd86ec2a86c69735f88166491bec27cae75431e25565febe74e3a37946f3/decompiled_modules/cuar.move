module 0x2900fd86ec2a86c69735f88166491bec27cae75431e25565febe74e3a37946f3::cuar {
    struct CUAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CUAR>(arg0, 9, b"CUAR", b"CUA", b"Mot con cua bien", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5cf6b085-c571-4fb7-b6a6-b7ca2bb2282f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CUAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CUAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

