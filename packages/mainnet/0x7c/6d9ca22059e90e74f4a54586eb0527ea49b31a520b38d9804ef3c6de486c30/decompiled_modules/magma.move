module 0x7c6d9ca22059e90e74f4a54586eb0527ea49b31a520b38d9804ef3c6de486c30::magma {
    struct MAGMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGMA>(arg0, 9, b"MAGMA", b"Magma Token", b"MAGMA is the native token of Magma Protocol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://strapi-space-bucket-fra1-1.fra1.cdn.digitaloceanspaces.com/Magma_Token_logo_36ca6d409d.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAGMA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<MAGMA>>(0x2::coin::mint<MAGMA>(&mut v2, 190000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MAGMA>>(v2);
    }

    // decompiled from Move bytecode v6
}

