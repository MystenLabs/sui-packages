module 0x28ca7edae29496bcacb88b9806a0eca9ffe25fad3614380ccf73d9eb6f1902bc::clm {
    struct CLM has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLM>(arg0, 9, b"CLM", b"CLAIM", b"Drops Rewards", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/19c0c3dc-8866-4afc-b3ff-061a04aefe94.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CLM>>(v1);
    }

    // decompiled from Move bytecode v6
}

