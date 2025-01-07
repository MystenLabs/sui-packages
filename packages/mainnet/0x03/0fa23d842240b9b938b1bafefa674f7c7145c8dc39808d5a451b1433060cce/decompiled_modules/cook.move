module 0x30fa23d842240b9b938b1bafefa674f7c7145c8dc39808d5a451b1433060cce::cook {
    struct COOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: COOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COOK>(arg0, 9, b"COOK", b"LET HIM COOK", b"Are you Ready ?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1817845614203543552/PiAVCaTp_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<COOK>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COOK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COOK>>(v1);
    }

    // decompiled from Move bytecode v6
}

