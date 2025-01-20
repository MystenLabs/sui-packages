module 0xeff0d90d33fff8ab17ae18a8adf6d809bb81211f41932ae6e37df054068b513c::hlwb {
    struct HLWB has drop {
        dummy_field: bool,
    }

    fun init(arg0: HLWB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HLWB>(arg0, 4, b"HLWB", b"Hello world 1", b"Trump coin test!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://public-cdn.daossui.io/assets/tokens/f22cd2b0-d73f-11ef-a70f-556b339362b9")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HLWB>>(v1);
        0x2::coin::mint_and_transfer<HLWB>(&mut v2, 11000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HLWB>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

