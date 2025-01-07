module 0x4ddb8cbdd951f35f4e473aab29488e660d5558a2f01c0c21e7b534e7659fdd04::plankton {
    struct PLANKTON has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLANKTON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLANKTON>(arg0, 9, b"PLANKTON", b"Plankton Token", b"plankton is meme on sui chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1845085329243635714/mzN9C770.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PLANKTON>(&mut v2, 445000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLANKTON>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLANKTON>>(v1);
    }

    // decompiled from Move bytecode v6
}

