module 0xbdd5f6b7ad8f0155fc6e58a3599a05e1fee878d428f755d8ea418aedfdc93c7a::thc {
    struct THC has drop {
        dummy_field: bool,
    }

    fun init(arg0: THC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THC>(arg0, 9, b"THC", b"SUNMIN", x"4368c3a06f206de1bbab6e672062e1baa16e20c491e1babf6e206bc3aa6e68206b69e1babf6d207469e1bb816e206d69e1bb856e207068c3ad205468e1babf2048c3b96e672043727970746f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/20826c13-1f2f-46ae-a1ff-9c99fe89e31a-20240822_201605.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<THC>>(v1);
    }

    // decompiled from Move bytecode v6
}

