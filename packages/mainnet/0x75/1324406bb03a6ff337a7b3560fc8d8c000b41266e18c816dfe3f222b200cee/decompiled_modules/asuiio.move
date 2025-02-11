module 0x751324406bb03a6ff337a7b3560fc8d8c000b41266e18c816dfe3f222b200cee::asuiio {
    struct ASUIIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASUIIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASUIIO>(arg0, 6, b"asui.io", b"aSUI staking reward claimable at asui.io", b"staking reward", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/yn4pT8mZ/images-1.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ASUIIO>(&mut v2, 10000000000 * 0x1::u64::pow(10, 6), 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASUIIO>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASUIIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

