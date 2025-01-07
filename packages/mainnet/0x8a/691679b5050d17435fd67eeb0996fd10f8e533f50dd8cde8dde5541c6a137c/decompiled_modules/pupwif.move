module 0x8a691679b5050d17435fd67eeb0996fd10f8e533f50dd8cde8dde5541c6a137c::pupwif {
    struct PUPWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUPWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUPWIF>(arg0, 9, b"PUPWIF", b"Pupwifhat", b"Pupwif is a fun, community-driven token offering fast, secure transactions on a scalable blockchain. Designed for dog lovers and crypto enthusiasts, it fosters a playful yet rewarding ecosystem in the decentralized finance space.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1787269138022346752/L1O_nSjy.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PUPWIF>(&mut v2, 750000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUPWIF>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUPWIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

