module 0x209dd1327fd364d4a6db353cc8014f911a60b2f6c60ec88f764dfdf136a70019::aya {
    struct AYA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AYA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AYA>(arg0, 9, b"AYA", b"Maiaya l", b"It's good web3 token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bbc1cebb-0192-4799-a011-2dd5d14b8ab6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AYA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AYA>>(v1);
    }

    // decompiled from Move bytecode v6
}

