module 0xad76ef53d95a035eff48f8c174aa50707471f406d7402f0629ee5e894c10a61a::px {
    struct PX has drop {
        dummy_field: bool,
    }

    fun init(arg0: PX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PX>(arg0, 9, b"PX", b"Notpixel ", b"Token gambling", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/668f1bb4-8011-44dd-aa3c-d9224ace5c73.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PX>>(v1);
    }

    // decompiled from Move bytecode v6
}

