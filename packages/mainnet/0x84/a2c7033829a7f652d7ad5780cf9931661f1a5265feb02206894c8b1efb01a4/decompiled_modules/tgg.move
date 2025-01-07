module 0x84a2c7033829a7f652d7ad5780cf9931661f1a5265feb02206894c8b1efb01a4::tgg {
    struct TGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: TGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TGG>(arg0, 9, b"TGG", b"tiger", b"Reach the top with us", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8b20be1e-7530-4d3c-ba7c-e5d82800fd90.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TGG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TGG>>(v1);
    }

    // decompiled from Move bytecode v6
}

