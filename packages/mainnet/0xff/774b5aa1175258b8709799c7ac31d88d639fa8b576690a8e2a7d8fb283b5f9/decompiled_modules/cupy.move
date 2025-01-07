module 0xff774b5aa1175258b8709799c7ac31d88d639fa8b576690a8e2a7d8fb283b5f9::cupy {
    struct CUPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CUPY>(arg0, 9, b"CUPY", b"Copy", b"Cupy copy ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/32dba432-6577-41bd-b22c-11c76df99271.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CUPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CUPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

