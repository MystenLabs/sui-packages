module 0x2bb278a9d859dd0cb2d5bb774c1f0f3c694b2b2a3cd9b2bfd1a62f5c0ba0aee0::cat {
    struct CAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAT>(arg0, 9, b"CAT", b"Tabby cat", b"The tabby cat is a symbol of agility and intelligence. With its distinctive striped coat, bright round eyes and friendly personality, the tabby cat has captured the hearts of many cat lovers.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d7650fff-c97f-4bd6-814d-336212537d3b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

