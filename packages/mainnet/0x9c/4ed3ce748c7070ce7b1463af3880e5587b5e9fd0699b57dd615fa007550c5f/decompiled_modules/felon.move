module 0x9c4ed3ce748c7070ce7b1463af3880e5587b5e9fd0699b57dd615fa007550c5f::felon {
    struct FELON has drop {
        dummy_field: bool,
    }

    fun init(arg0: FELON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FELON>(arg0, 9, b"FELON", b"felon", b"Trump is a felon.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1695053326654607360/o4wjRrfE_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FELON>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FELON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FELON>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

