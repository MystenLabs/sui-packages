module 0x6a7cb9e5536349d51c5c77a80e71aa51de4a8b3a0855c852f27716a1851b5b66::suimen {
    struct SUIMEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMEN>(arg0, 6, b"SUIMEN", b"SuiMen", x"496620497420446f65736e2774205461737465204c696b6520245355494d454e2c2049276d204e6f7420427579696e672049742e200a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_11_04_56_07_2_b29666f893_f001e42806.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

