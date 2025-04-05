module 0xa6449d6217ef1faa11e022a54e8fa4754b57e988d162e5db9f7e8dc71459a66f::dada {
    struct DADA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DADA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DADA>(arg0, 6, b"DADA", b"DADA", b"dsadsadasda", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://beige-abstract-pig-256.mypinata.cloud/ipfs/bafkreid4gkpwv7gs265rgt5j63jltas4yaaxtcddy3n6bvrl5v2mxjgiam")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DADA>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DADA>>(v2, @0x384b4f03fd3fccec0a9f0d26595e4e2b1ab289efb9213668b2f41bceb4ecd524);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DADA>>(v1);
    }

    // decompiled from Move bytecode v6
}

