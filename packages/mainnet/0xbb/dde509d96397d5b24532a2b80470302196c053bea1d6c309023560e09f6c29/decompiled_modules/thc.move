module 0xbbdde509d96397d5b24532a2b80470302196c053bea1d6c309023560e09f6c29::thc {
    struct THC has drop {
        dummy_field: bool,
    }

    fun init(arg0: THC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THC>(arg0, 9, b"THC", x"5468e1babf2048c3b96e672043", x"4368c3a06f206de1bbab6e672062e1baa16e20c491e1babf6e206bc3aa6e68206b69e1babf6d207469e1bb816e2063e1bba761205468e1babf2048c3b96e672043727970746f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e02760d5-4eb9-4277-9824-ce3e55226f97.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<THC>>(v1);
    }

    // decompiled from Move bytecode v6
}

