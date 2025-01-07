module 0x2bee8beb29b426ed79de94bb19b447bc0692ffa9c5ea732a5b9719ba5d2c9164::kkk {
    struct KKK has drop {
        dummy_field: bool,
    }

    fun init(arg0: KKK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KKK>(arg0, 9, b"KKK", b"Hao", b"Haotk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/629e71b3-7588-4247-8289-4423adadcf73.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KKK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KKK>>(v1);
    }

    // decompiled from Move bytecode v6
}

