module 0x82dd79824274a9613e6622b394b6ddc410bbe40a419194f2c1c08598a5a55236::sanjay {
    struct SANJAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SANJAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SANJAY>(arg0, 6, b"SANJAY", b"Indian ori", b"DEV BASED INDIA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731000560614.avif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SANJAY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SANJAY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

