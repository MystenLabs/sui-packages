module 0x3969ac3f58b6b3084b368c21652684d55263b337190a00accd0e46dc21d4c8af::hlwf {
    struct HLWF has drop {
        dummy_field: bool,
    }

    fun init(arg0: HLWF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HLWF>(arg0, 2, b"HLWF", b"Hello world 6", b"Test description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://public-cdn.daossui.io/assets/tokens/1bbf1e80-d745-11ef-a70f-556b339362b9")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HLWF>>(v1);
        0x2::coin::mint_and_transfer<HLWF>(&mut v2, 110000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HLWF>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

