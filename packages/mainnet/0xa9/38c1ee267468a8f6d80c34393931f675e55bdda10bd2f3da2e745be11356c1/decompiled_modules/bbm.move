module 0xa938c1ee267468a8f6d80c34393931f675e55bdda10bd2f3da2e745be11356c1::bbm {
    struct BBM has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBM>(arg0, 9, b"BBM", b"Baby Meow", b"Happy cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/61c233c6-5e77-4632-9808-b92d75560c5e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BBM>>(v1);
    }

    // decompiled from Move bytecode v6
}

