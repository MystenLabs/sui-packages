module 0xcee39b59fcd3a035928bbce911e3437af24dee15a7850f9edbce7ff5ec0ef1f3::suipro {
    struct SUIPRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPRO>(arg0, 9, b"SUIPRO", b"SUIPRO", b"This is SUIPRO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/56954475?v=4")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIPRO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPRO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

