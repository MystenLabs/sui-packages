module 0x5a51ae0a9b8f2d5227338d0fecbde71fa891ca8a3cbc6441415293433a2ea554::me {
    struct ME has drop {
        dummy_field: bool,
    }

    fun init(arg0: ME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ME>(arg0, 9, b"ME", b"Meow", b"Meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/61d5c512-34bc-4cde-9908-1abef292c43c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ME>>(v1);
    }

    // decompiled from Move bytecode v6
}

