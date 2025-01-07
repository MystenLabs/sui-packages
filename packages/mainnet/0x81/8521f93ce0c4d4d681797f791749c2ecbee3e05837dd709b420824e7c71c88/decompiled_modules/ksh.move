module 0x818521f93ce0c4d4d681797f791749c2ecbee3e05837dd709b420824e7c71c88::ksh {
    struct KSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: KSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KSH>(arg0, 9, b"KSH", b"kushvaha b", b"Tradeble on all plateform", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fbd3703e-cbd3-4a0d-b070-fe136e031434.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KSH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KSH>>(v1);
    }

    // decompiled from Move bytecode v6
}

