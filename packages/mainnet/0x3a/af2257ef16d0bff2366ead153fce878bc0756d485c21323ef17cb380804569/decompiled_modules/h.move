module 0x3aaf2257ef16d0bff2366ead153fce878bc0756d485c21323ef17cb380804569::h {
    struct H has drop {
        dummy_field: bool,
    }

    fun init(arg0: H, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<H>(arg0, 6, b"H", b"Testdontbuysjsj", b"Hi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4582_7c02bb5159.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<H>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<H>>(v1);
    }

    // decompiled from Move bytecode v6
}

