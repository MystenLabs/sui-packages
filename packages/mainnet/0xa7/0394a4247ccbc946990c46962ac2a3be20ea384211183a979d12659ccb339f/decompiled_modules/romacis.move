module 0xa70394a4247ccbc946990c46962ac2a3be20ea384211183a979d12659ccb339f::romacis {
    struct ROMACIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROMACIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROMACIS>(arg0, 9, b"ROMACIS", b"romabis", b"the new", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3d2238a1-1998-4435-8887-660c1f2fa4cf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROMACIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROMACIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

