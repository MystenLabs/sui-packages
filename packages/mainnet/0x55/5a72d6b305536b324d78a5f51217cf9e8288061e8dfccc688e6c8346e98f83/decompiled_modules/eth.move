module 0x555a72d6b305536b324d78a5f51217cf9e8288061e8dfccc688e6c8346e98f83::eth {
    struct ETH has drop {
        dummy_field: bool,
    }

    fun init(arg0: ETH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ETH>(arg0, 9, b"ETH", b"Ethereum ", b"Goo to moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b43d5aaf-422f-49b1-afa4-bfa8d1bca822.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ETH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ETH>>(v1);
    }

    // decompiled from Move bytecode v6
}

