module 0x6fe54837afe8d69e35348bca2b0207483da3971057875d0e6573edffa4a8116f::oink {
    struct OINK has drop {
        dummy_field: bool,
    }

    fun init(arg0: OINK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OINK>(arg0, 6, b"OINK", b"OINKPIG", b"The word oink is an onomatopoeic expression that imitates the sound made by pigs or hogs. It is commonly used in English to describe the noise pigs make, often spelled as \"oink\" to represent the sound itself. This sound is associated with the gruntin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732912040983.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OINK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OINK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

