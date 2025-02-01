module 0x85f7617f8c3d881a14b394c5d693be230c6d861b32d682232f4e8fdf5d8d473e::voody {
    struct VOODY has drop {
        dummy_field: bool,
    }

    fun init(arg0: VOODY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VOODY>(arg0, 6, b"VOODY", b"Voody Sui", b"Vini Voody Vici", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1738432259357.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VOODY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VOODY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

