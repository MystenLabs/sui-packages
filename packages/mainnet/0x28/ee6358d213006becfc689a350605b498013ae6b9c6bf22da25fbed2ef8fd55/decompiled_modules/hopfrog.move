module 0x28ee6358d213006becfc689a350605b498013ae6b9c6bf22da25fbed2ef8fd55::hopfrog {
    struct HOPFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPFROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPFROG>(arg0, 6, b"HopFrog", b"HopFrogSui", b"\"Time spins like a clock, turning endlessly, much like a ninja star whirling through the air.\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731075265182.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOPFROG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPFROG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

