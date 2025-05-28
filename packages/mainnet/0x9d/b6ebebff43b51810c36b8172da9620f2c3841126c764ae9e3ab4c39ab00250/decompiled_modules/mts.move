module 0x9db6ebebff43b51810c36b8172da9620f2c3841126c764ae9e3ab4c39ab00250::mts {
    struct MTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MTS>(arg0, 6, b"MTS", b"Mamoth Sui", b"Mamoth Sui mission is to be a privacy-centric blockchain managing the entire information lifecycle of an Internet of Things Sui network, including data collection, transport, storage, and utilization.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1748427020701.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MTS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MTS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

