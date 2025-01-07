module 0xe136f5543a8d2489e8d4972127be7c4862e9d28761825f6c73d0316d81931e7a::nogod {
    struct NOGOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOGOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOGOD>(arg0, 9, b"NOGOD", b"NO GOD", b"Atheism", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cab16f83-613c-4d1b-b956-bd70a4092597.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOGOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NOGOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

