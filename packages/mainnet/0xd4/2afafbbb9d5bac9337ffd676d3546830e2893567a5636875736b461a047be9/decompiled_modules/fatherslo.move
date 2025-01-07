module 0xd42afafbbb9d5bac9337ffd676d3546830e2893567a5636875736b461a047be9::fatherslo {
    struct FATHERSLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FATHERSLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FATHERSLO>(arg0, 9, b"FATHERSLO", b"Fatherslo", b"Ftherslow", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e3ddcb48-2fbd-49fb-805e-63a889172706.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FATHERSLO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FATHERSLO>>(v1);
    }

    // decompiled from Move bytecode v6
}

