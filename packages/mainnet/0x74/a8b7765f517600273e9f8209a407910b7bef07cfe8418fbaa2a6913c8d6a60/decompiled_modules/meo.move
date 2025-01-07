module 0x74a8b7765f517600273e9f8209a407910b7bef07cfe8418fbaa2a6913c8d6a60::meo {
    struct MEO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEO>(arg0, 9, b"MEO", b"Meo", b"a cat ready to prey on a greedy mouse", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3074d1cc-402e-458f-be46-a55710e1b50a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEO>>(v1);
    }

    // decompiled from Move bytecode v6
}

