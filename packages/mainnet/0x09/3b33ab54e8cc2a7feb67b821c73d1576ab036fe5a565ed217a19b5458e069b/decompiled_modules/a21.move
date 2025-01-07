module 0x93b33ab54e8cc2a7feb67b821c73d1576ab036fe5a565ed217a19b5458e069b::a21 {
    struct A21 has drop {
        dummy_field: bool,
    }

    fun init(arg0: A21, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<A21>(arg0, 9, b"A21", b"Weve", b"Great one", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/43e903ac-cc61-4f86-9271-639386b247ea.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<A21>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<A21>>(v1);
    }

    // decompiled from Move bytecode v6
}

