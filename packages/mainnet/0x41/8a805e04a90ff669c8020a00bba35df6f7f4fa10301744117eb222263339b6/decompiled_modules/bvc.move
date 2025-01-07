module 0x418a805e04a90ff669c8020a00bba35df6f7f4fa10301744117eb222263339b6::bvc {
    struct BVC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BVC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BVC>(arg0, 9, b"BVC", b"DF", b"VC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/840f687f-2c42-44db-a32b-4880ee91f0f2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BVC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BVC>>(v1);
    }

    // decompiled from Move bytecode v6
}

