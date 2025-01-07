module 0x4c1f9172eda4c493475928000c3cde7beccafed458d3a33999c8e05215901e01::rosa {
    struct ROSA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROSA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROSA>(arg0, 6, b"Rosa", b"Rosa the Sea Otter", b"Rosa the Sea Otter on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2024_10_14_15_36_12_a65e270970.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROSA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROSA>>(v1);
    }

    // decompiled from Move bytecode v6
}

