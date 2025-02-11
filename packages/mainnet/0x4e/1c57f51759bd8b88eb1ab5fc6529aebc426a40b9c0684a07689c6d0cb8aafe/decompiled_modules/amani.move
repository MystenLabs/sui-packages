module 0x4e1c57f51759bd8b88eb1ab5fc6529aebc426a40b9c0684a07689c6d0cb8aafe::amani {
    struct AMANI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMANI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMANI>(arg0, 9, b"AMANI", b"AMANI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSdYe9nbwhbLakxf_fbIc4g9bHbRpIP_eKIAsPs0WFX9AI4LQzXyu4tIz2t70bkUOgsA8I&usqp=CAU")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AMANI>>(v1);
        0x2::coin::mint_and_transfer<AMANI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMANI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

