module 0xe32050d134a0147347a38e0b91c4fce9fda77d537ad4f892fcfbcb006ae4506b::des {
    struct DES has drop {
        dummy_field: bool,
    }

    fun init(arg0: DES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DES>(arg0, 9, b"DES", b"DESRTSCD", b"AJVNJKDE99D", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DES>(&mut v2, 1000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DES>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DES>>(v1);
    }

    // decompiled from Move bytecode v6
}

