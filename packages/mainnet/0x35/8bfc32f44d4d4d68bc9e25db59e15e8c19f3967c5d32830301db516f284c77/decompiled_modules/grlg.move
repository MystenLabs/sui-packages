module 0x358bfc32f44d4d4d68bc9e25db59e15e8c19f3967c5d32830301db516f284c77::grlg {
    struct GRLG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRLG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRLG>(arg0, 9, b"GRLG", b"TENAGE", x"496e7370697265642062792074686520737472656e67746820616e6420737069726974206f66206769726c730a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c495ed88-d721-423f-87c0-520f8f42d209.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRLG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GRLG>>(v1);
    }

    // decompiled from Move bytecode v6
}

