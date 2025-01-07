module 0x2022c8d196d6c0812e90456a6c342ed69e8570c6577881d38e7edfae51923a05::vital {
    struct VITAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: VITAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VITAL>(arg0, 9, b"VITAL", b"VIT", b"ViTaL coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d25f53bb-dc28-45b4-bb41-2d4129f0acbf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VITAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VITAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

