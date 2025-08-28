module 0xb9ff500182a6766b04a6f45160f0d1d633467f7494eaeb4f312364c2ee336a0e::Frens {
    struct FRENS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRENS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRENS>(arg0, 9, b"MAGICAL", b"Frens", b"magical unicorn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/GzX6hnhXYAAIkwf?format=jpg&name=large")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FRENS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRENS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

