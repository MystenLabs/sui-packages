module 0x894f520ea755550b75c33170403045e74b9a856aed393aeb139847289fb15d46::niyicat {
    struct NIYICAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIYICAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIYICAT>(arg0, 6, b"NIYICAT", b"Adeniyi Cat", b"The meme token thats as smooth as Adeniyis shiny head!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_6285150558968989408_x_92f48d7c59.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIYICAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NIYICAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

