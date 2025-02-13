module 0xf838b27c5332635b877bb0902c5520af769530ed8a21aa48adad8b7681a043dc::fan {
    struct FAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAN>(arg0, 9, b"FAN", b"FanTV AI", b"FAN is the native token of FanTV Platform", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets.artistfirst.in/uploads/1739349932784-FAN_logo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAN>>(v1);
        0x2::coin::mint_and_transfer<FAN>(&mut v2, 10000000000 * 1000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<FAN>>(v2);
    }

    // decompiled from Move bytecode v6
}

