module 0x8a1d5e193173f54e968180fb2820dd739600494a5bdd8cf35ebf2c06c9fe755d::pik {
    struct PIK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIK>(arg0, 9, b"PIK", b"Pika Pika ", b"Pika Pika Pi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fdf7c1f4-2ca1-4f4f-80b6-588793ad5f99.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIK>>(v1);
    }

    // decompiled from Move bytecode v6
}

