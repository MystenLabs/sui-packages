module 0xed05a9e6edc748790c516f98623fbc1c4b8e6f27f25fd0d0b68f3896adc5e644::suix {
    struct SUIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIX>(arg0, 9, b"SUIX", b"SUI6900", b"NEXT SUI6900 // https://www.sui6900.fun/ // https://t.me/sui6900portal // https://x.com/sui6900x", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1728822962160-55a5e17337a4ff224c8a70b78848abee.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIX>(&mut v2, 120000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIX>>(v2, @0x20dfd53f870d98857765876f529a2c6d0b9c8508705b42935414be21348497e0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIX>>(v1);
    }

    // decompiled from Move bytecode v6
}

