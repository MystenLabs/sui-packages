module 0xd17eb57e672b59c340c2a9722bf4492d5af13fdbe81c7dd9fcacfc817b85997b::ffc {
    struct FFC has drop {
        dummy_field: bool,
    }

    fun init(arg0: FFC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FFC>(arg0, 9, b"FFC", b"Futurefeed", x"4974e280997320737569206d656d6520636f696e20666f722062697264207472616e7366657220", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fd2f97ac-8158-403b-a1bb-f190307620c1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FFC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FFC>>(v1);
    }

    // decompiled from Move bytecode v6
}

