module 0x797f8406b70df4284f0673e95163f025f02b4dbefe18a50016599c2c73051b4c::mystictom {
    struct MYSTICTOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: MYSTICTOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MYSTICTOM>(arg0, 6, b"MysticTom", b"Tom", b"Holle,I'm Scary Beans NFT COO, Love Meta believer", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/yk_Lla_Ljh_400x400_22d566e7a6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYSTICTOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MYSTICTOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

