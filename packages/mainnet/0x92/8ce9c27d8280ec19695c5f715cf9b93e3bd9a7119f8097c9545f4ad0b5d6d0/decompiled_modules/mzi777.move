module 0x928ce9c27d8280ec19695c5f715cf9b93e3bd9a7119f8097c9545f4ad0b5d6d0::mzi777 {
    struct MZI777 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MZI777, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MZI777>(arg0, 6, b"MZI777", b"MZI", b"Good ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3269_e8cfdb8929.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MZI777>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MZI777>>(v1);
    }

    // decompiled from Move bytecode v6
}

