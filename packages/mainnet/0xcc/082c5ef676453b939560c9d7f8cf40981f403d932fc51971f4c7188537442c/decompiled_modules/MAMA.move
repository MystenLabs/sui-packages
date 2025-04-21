module 0xcc082c5ef676453b939560c9d7f8cf40981f403d932fc51971f4c7188537442c::MAMA {
    struct MAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAMA>(arg0, 6, b"MAMA", b"mama a girl behind you", b"mommy mama mama bitmoji queen", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://uptos-pump.myfilebase.com/ipfs/QmXMYqJrJ4dg6Q3cu2Eo7RaW8V2uUo1BCRYajikqSZpNhC")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAMA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAMA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

