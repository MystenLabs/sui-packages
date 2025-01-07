module 0x5bd8e34438b183f70ab8d09ce9e958c3998d639f838bb0a0515c2f8edc06276d::sun {
    struct SUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUN>(arg0, 9, b"SUN", b"SUN", b"Sorry Unlucky Noo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.ouinolanguages.com/assets/French/vocab/8/images/pic7.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUN>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

