module 0x8a9685d17624104cf57b5a7877df3383e340e09e92ba98b0231bb8254f2b9c2f::suishib {
    struct SUISHIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISHIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISHIB>(arg0, 6, b"SUISHIB", b"SUI SHIB", b"https://t.me/sui_shib", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_13_00_04_55_8e20e0a866.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISHIB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISHIB>>(v1);
    }

    // decompiled from Move bytecode v6
}

