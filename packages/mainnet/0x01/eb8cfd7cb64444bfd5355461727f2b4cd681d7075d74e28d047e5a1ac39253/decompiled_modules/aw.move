module 0x1eb8cfd7cb64444bfd5355461727f2b4cd681d7075d74e28d047e5a1ac39253::aw {
    struct AW has drop {
        dummy_field: bool,
    }

    fun init(arg0: AW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AW>(arg0, 6, b"Aw", b"aaawater", b"Water from masturbation", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6553_b5cd2a1e4a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AW>>(v1);
    }

    // decompiled from Move bytecode v6
}

