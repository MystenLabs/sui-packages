module 0x49f7241cb1c70aa1b3648b28774dc6e94ab5bf450c34887590208a68a9b711a0::babyhippo {
    struct BABYHIPPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYHIPPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYHIPPO>(arg0, 6, b"BabyHippo", b"Baby Hippo", b"No Cats, No Dogs Only Hippo! Baby Hippo was born on BNB Chain, to promote this wave with the mission of spreading the cuteness of hippos and join hands to raise awareness of protecting wild animals of people around the world!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_15_15_06_17_86aecbfd78.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYHIPPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYHIPPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

