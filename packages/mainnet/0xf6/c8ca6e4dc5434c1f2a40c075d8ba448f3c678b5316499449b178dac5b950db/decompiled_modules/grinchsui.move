module 0xf6c8ca6e4dc5434c1f2a40c075d8ba448f3c678b5316499449b178dac5b950db::grinchsui {
    struct GRINCHSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRINCHSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRINCHSUI>(arg0, 6, b"GrinchSui", b"Grinch on Sui", b"Grinch appeared on the Christmas morning.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/256x256_43c30fed5b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRINCHSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GRINCHSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

