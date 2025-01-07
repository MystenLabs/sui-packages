module 0x9d162eb2726e12936d41567c01cdd7aff5d9a428511eacfe83e21793ea932c1d::seasilies {
    struct SEASILIES has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEASILIES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEASILIES>(arg0, 8, b"SEASILIES", b"SeaSillies", b"gem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSdv2JyeJ0YrNtGj3hYcJcUPkrX_u26aCfUA4Pd-kvezY6MkdSMGFhSG5au7DmXJRendOQ&usqp=CAU")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SEASILIES>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEASILIES>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEASILIES>>(v1);
    }

    // decompiled from Move bytecode v6
}

