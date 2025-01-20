module 0x7f8ef14d14e81f7ce9f47171676bd1d84a656580715686a87dc78279b287ed0c::hlwe {
    struct HLWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HLWE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HLWE>(arg0, 3, b"HLWE", b"hello world 5", b"Test ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://public-cdn.daossui.io/assets/tokens/4b9049f0-d744-11ef-a70f-556b339362b9")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HLWE>>(v1);
        0x2::coin::mint_and_transfer<HLWE>(&mut v2, 1100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HLWE>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

