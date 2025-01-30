module 0x9242f4d7725510d7e0dc520be0ce97e1578c37f6f315cbcf137e2db753c5abc8::nitro {
    struct NITRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NITRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NITRO>(arg0, 9, b"NITRO", b"Nitro", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmXTvQQebrMvrcznEw6RWqc6eQfaTiwjhTd5VfRDGrzMsu")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NITRO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NITRO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NITRO>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

