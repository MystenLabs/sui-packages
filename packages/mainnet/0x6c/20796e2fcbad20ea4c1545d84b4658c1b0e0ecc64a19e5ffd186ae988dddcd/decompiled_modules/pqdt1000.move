module 0x6c20796e2fcbad20ea4c1545d84b4658c1b0e0ecc64a19e5ffd186ae988dddcd::pqdt1000 {
    struct PQDT1000 has drop {
        dummy_field: bool,
    }

    fun init(arg0: PQDT1000, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PQDT1000>(arg0, 9, b"Pqdt1000", b"TIGER.1000", b"Release the letter little tiger...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/c2f2ef3e08aa87071a10795fad8695b2blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PQDT1000>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PQDT1000>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

