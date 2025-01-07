module 0xc3a898df3df73911f1d69da666b6ec7fd6ccd529d938aacf1332a4d8f8a9e921::tik {
    struct TIK has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIK>(arg0, 9, b"TIK", b"tik", x"6b656570696e6720796f757220706f7274666f6c696f2062757a7a696e67207769746820766972616c2070726f6669747320e29c85", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/97d08cf3-43b9-42b4-9ed3-3638199d24d4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TIK>>(v1);
    }

    // decompiled from Move bytecode v6
}

