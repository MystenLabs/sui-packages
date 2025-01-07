module 0x10d1c70ef8ea99d8901e0c84cd32ea5534abcf59d505a10c347f6a40aa186b04::benhuhht {
    struct BENHUHHT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BENHUHHT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BENHUHHT>(arg0, 6, b"BENHUHHT", b"BENHUHH-T", b"Meet Ben, The 'Huh' Cat with Hat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_10_23_32_00_68944bb247.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BENHUHHT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BENHUHHT>>(v1);
    }

    // decompiled from Move bytecode v6
}

