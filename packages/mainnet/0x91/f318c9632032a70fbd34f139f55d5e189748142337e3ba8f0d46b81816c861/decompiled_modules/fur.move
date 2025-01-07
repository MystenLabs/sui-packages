module 0x91f318c9632032a70fbd34f139f55d5e189748142337e3ba8f0d46b81816c861::fur {
    struct FUR has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUR>(arg0, 9, b"FUR", b"Furry Quest", b"of which animal is this fur", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/44a28734d2a989c1c0cb8ac090ac0098blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FUR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

