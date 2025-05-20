module 0xea7acc998353ecf8c1e5e5a0dc54768b752bace0dc6d09399e27128d6620c112::qucc {
    struct QUCC has drop {
        dummy_field: bool,
    }

    fun init(arg0: QUCC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QUCC>(arg0, 6, b"QUCC", b"QUCC TO A BUCC", b"$QUCC is the heart of the hustle. Tiny but relentless, this duck is building a flock of true believers. Join the waddle and ride the waves!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiasyzsw46t3lajl6rhjzslf33ukipij3gfxylsdb2lw4ex6ry3q4u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QUCC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<QUCC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

