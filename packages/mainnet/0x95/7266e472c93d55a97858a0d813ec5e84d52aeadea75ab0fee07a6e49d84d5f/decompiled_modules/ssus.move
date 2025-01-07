module 0x957266e472c93d55a97858a0d813ec5e84d52aeadea75ab0fee07a6e49d84d5f::ssus {
    struct SSUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSUS>(arg0, 6, b"SSUS", b"SUSSUI", b"$ssus memes in the trenches", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/u_IO_Me1_A6_400x400_copy_3ed2ee4956.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

