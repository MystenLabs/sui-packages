module 0xad60a7a9ae016ffb9d5b8f2d13fadba93b217f89823c2fbd51cc9e317c7d774b::sasi {
    struct SASI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SASI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SASI>(arg0, 9, b"Sasi", b"saii", b"I AM HUNTER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/3779c85259ebc8040da12f12bf4ecb97blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SASI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SASI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

