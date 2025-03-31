module 0x1ec35bf785f5ca71d53cc1032445358c398fff8aa9a9deb1ab5575d7d365516c::zuu {
    struct ZUU has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZUU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZUU>(arg0, 9, b"Zuu", b"Zuckerberg", x"4d61726b205a75636b6572626572670a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/bb33926eae87328a81c7336e080ba795blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZUU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZUU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

