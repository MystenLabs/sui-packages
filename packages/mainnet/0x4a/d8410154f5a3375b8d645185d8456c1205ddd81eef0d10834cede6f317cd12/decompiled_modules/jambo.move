module 0x4ad8410154f5a3375b8d645185d8456c1205ddd81eef0d10834cede6f317cd12::jambo {
    struct JAMBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAMBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAMBO>(arg0, 9, b"JAMBO", b"JAMBO", b"Building the world's largest on-chain mobile ecosystem starting with the JamboPhone", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1846515508503580673/_sCL7xZw_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<JAMBO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JAMBO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAMBO>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

