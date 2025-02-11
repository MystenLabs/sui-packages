module 0xbdcb2e30ea0022ace6f545097fb07564c7d4c7eec0885a36e19376eed76d054::asuiio {
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

