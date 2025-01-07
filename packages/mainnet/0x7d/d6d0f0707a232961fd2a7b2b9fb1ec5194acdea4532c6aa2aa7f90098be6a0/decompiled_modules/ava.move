module 0x7dd6d0f0707a232961fd2a7b2b9fb1ec5194acdea4532c6aa2aa7f90098be6a0::ava {
    struct AVA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AVA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AVA>(arg0, 6, b"AVA", b"AVASUI", b"Avatar oh this whay last airbender in crypto world ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000196889_58fbfab616.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AVA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AVA>>(v1);
    }

    // decompiled from Move bytecode v6
}

