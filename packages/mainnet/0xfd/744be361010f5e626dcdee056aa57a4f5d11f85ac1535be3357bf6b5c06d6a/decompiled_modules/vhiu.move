module 0xfd744be361010f5e626dcdee056aa57a4f5d11f85ac1535be3357bf6b5c06d6a::vhiu {
    struct VHIU has drop {
        dummy_field: bool,
    }

    fun init(arg0: VHIU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VHIU>(arg0, 9, b"VHIU", b"Black", b"Just black tocken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2f756fea-1c8d-47ae-8ae8-adb3b351cf0f-1000021853.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VHIU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VHIU>>(v1);
    }

    // decompiled from Move bytecode v6
}

