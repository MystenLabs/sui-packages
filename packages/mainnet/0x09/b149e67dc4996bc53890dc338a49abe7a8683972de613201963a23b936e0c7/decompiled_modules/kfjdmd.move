module 0x9b149e67dc4996bc53890dc338a49abe7a8683972de613201963a23b936e0c7::kfjdmd {
    struct KFJDMD has drop {
        dummy_field: bool,
    }

    fun init(arg0: KFJDMD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KFJDMD>(arg0, 9, b"KFJDMD", b"Ldhsmd", b"Dlkdk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b30e3df4-5055-4131-a3d8-fd04efbb33ab.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KFJDMD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KFJDMD>>(v1);
    }

    // decompiled from Move bytecode v6
}

