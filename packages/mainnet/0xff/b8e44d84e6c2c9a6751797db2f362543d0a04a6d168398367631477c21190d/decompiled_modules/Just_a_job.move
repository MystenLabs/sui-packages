module 0xffb8e44d84e6c2c9a6751797db2f362543d0a04a6d168398367631477c21190d::Just_a_job {
    struct JUST_A_JOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUST_A_JOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUST_A_JOB>(arg0, 9, b"JOB", b"Just a job", b"its a tough job to work", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1936002956333080576/kqqe2iWO_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JUST_A_JOB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUST_A_JOB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

