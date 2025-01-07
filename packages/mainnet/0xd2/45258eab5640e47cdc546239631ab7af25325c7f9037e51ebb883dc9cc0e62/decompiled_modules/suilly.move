module 0xd245258eab5640e47cdc546239631ab7af25325c7f9037e51ebb883dc9cc0e62::suilly {
    struct SUILLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILLY>(arg0, 9, b"suilly", b"Suilly", b"Mascot Sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdnb.artstation.com/p/assets/images/images/080/618/561/large/-rr032.jpg?1728044756")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUILLY>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILLY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

