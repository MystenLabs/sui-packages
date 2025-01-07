module 0x7cc318de90842ff28cf1a2e9884b815000c217a89a40bd55f64266ee64d18f47::y {
    struct Y has drop {
        dummy_field: bool,
    }

    fun init(arg0: Y, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<Y>(arg0, 9, b"Y", b"Ye", b"Good one", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b6ebb2f3-9838-4620-af31-d88cdeabe70e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<Y>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<Y>>(v1);
    }

    // decompiled from Move bytecode v6
}

