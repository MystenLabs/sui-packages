module 0xeab19cbee555406bb2d10f2a06d3b5d362a3153d5b6e1c1eec7b4ad8133f81ef::pvp {
    struct PVP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PVP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PVP>(arg0, 6, b"PVP", b"Sui Traders CTO", b"Last place to shill your project. everything gets rekt after PVP in here. I hope everyone is in the TG. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_24_15_43_09_4180a3ddad.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PVP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PVP>>(v1);
    }

    // decompiled from Move bytecode v6
}

