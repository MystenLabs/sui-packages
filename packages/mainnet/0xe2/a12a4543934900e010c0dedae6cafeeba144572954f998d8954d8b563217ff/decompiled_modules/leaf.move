module 0xe2a12a4543934900e010c0dedae6cafeeba144572954f998d8954d8b563217ff::leaf {
    struct LEAF has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEAF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEAF>(arg0, 9, b"LEAF", b"yellowleaf", b"A quirky memecoin based on a quirky meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a29595bf-6020-4865-aef7-b928b27dc945.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LEAF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LEAF>>(v1);
    }

    // decompiled from Move bytecode v6
}

