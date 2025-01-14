module 0x5c9d27f789cdea939f085edc89b38e758a88f236233d4ad61ab3ce358537d48::aloevera {
    struct ALOEVERA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALOEVERA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALOEVERA>(arg0, 6, b"AloeVera", b"Aloe Vera", b"Since GREEN ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000020302_4b477bbe4d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALOEVERA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ALOEVERA>>(v1);
    }

    // decompiled from Move bytecode v6
}

