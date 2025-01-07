module 0x8438bd9097b971e85f4c851de1f761a1949f6fcf6928d62d10b65205412c0734::bdog {
    struct BDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BDOG>(arg0, 6, b"BDOG", b"BUTTER DOG ON SUI", b"Butter on the dog, dog in the butter, portfolio on fire.  Some Genius Investor", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5795_c8bf7839f3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

