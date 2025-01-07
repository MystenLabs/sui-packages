module 0xdf7803f6beb0dd5c10e945851275a0b5811657bd16daf364e18f67aa7bf187d5::sper {
    struct SPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPER>(arg0, 9, b"SPER", b"SUIPER", b"SPER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQOsm6vftyo-7AHS_t-qGcc0ch4m7ZrEcb1Wg&usqp=CAU")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SPER>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPER>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPER>>(v1);
    }

    // decompiled from Move bytecode v6
}

