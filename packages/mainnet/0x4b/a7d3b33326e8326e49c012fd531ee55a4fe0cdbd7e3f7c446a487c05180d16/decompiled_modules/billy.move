module 0x4ba7d3b33326e8326e49c012fd531ee55a4fe0cdbd7e3f7c446a487c05180d16::billy {
    struct BILLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BILLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BILLY>(arg0, 6, b"BILLY", b"Billy the Dog", b"There's no one cuter than me, so adopt me! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730956074911.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BILLY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BILLY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

