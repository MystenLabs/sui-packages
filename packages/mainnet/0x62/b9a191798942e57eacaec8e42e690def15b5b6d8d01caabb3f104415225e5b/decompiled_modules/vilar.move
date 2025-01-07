module 0x62b9a191798942e57eacaec8e42e690def15b5b6d8d01caabb3f104415225e5b::vilar {
    struct VILAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: VILAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VILAR>(arg0, 6, b"VILAR", b"VILARSO DAO", b"Vilarsofree. First trader DAO on $SUI !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_114c970953.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VILAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VILAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

