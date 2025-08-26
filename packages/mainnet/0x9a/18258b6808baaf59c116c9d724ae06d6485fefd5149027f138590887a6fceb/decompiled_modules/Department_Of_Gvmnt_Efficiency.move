module 0x9a18258b6808baaf59c116c9d724ae06d6485fefd5149027f138590887a6fceb::Department_Of_Gvmnt_Efficiency {
    struct DEPARTMENT_OF_GVMNT_EFFICIENCY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEPARTMENT_OF_GVMNT_EFFICIENCY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEPARTMENT_OF_GVMNT_EFFICIENCY>(arg0, 9, b"DOGE", b"Department Of Gvmnt Efficiency", b"department of government efficiency is here. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1856763811186999296/p9VACiBj_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEPARTMENT_OF_GVMNT_EFFICIENCY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEPARTMENT_OF_GVMNT_EFFICIENCY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

