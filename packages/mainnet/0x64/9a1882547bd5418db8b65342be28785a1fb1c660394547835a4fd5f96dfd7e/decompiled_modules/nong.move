module 0x649a1882547bd5418db8b65342be28785a1fb1c660394547835a4fd5f96dfd7e::nong {
    struct NONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: NONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NONG>(arg0, 6, b"NONG", b"SUINONG", b"Meet $Nao Old Doll who will be the new mascot in crypto! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_11_13_48_11_2_a3d01c8c5c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NONG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NONG>>(v1);
    }

    // decompiled from Move bytecode v6
}

