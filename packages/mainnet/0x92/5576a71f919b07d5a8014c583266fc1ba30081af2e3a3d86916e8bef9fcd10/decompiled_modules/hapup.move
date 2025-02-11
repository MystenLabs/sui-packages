module 0x925576a71f919b07d5a8014c583266fc1ba30081af2e3a3d86916e8bef9fcd10::hapup {
    struct HAPUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAPUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAPUP>(arg0, 6, b"HaPup", b"Happy Puppy", b"Custest Happu Pup", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Designer_7d61bec859.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAPUP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAPUP>>(v1);
    }

    // decompiled from Move bytecode v6
}

