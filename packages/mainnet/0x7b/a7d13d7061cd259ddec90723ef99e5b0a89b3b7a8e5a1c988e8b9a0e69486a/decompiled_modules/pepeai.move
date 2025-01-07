module 0x7ba7d13d7061cd259ddec90723ef99e5b0a89b3b7a8e5a1c988e8b9a0e69486a::pepeai {
    struct PEPEAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPEAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPEAI>(arg0, 6, b"PEPEAI", b"Pepe Computer", b"Visit pepe.computer to use Pepe Computer", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3452345623456_c22c12df41.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPEAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPEAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

