module 0xdfd872fb60043cab1ee7104bf0ed91d1bf46d78bdb6875c6bc52975d7a6cd22b::copper {
    struct COPPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: COPPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COPPER>(arg0, 8, b"COPPER", b"COPPER COIN", b"The Backbone of the Blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.slaunch.xyz/assets/tokens/d67e65f9-b75b-4ac4-a806-914d6ef40008.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<COPPER>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COPPER>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COPPER>>(v1);
    }

    // decompiled from Move bytecode v6
}

