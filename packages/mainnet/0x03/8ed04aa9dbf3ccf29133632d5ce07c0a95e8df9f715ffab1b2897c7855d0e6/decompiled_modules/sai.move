module 0x38ed04aa9dbf3ccf29133632d5ce07c0a95e8df9f715ffab1b2897c7855d0e6::sai {
    struct SAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAI>(arg0, 6, b"SAI", b"SUI AI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://files.oaiusercontent.com/file-KvcV0XOihKv36QdKNGJEPkUk?se=2024-01-12T16%3A01%3A08Z&sp=r&sv=2021-08-06&sr=b&rscc=max-age%3D31536000%2C%20immutable&rscd=attachment%3B%20filename%3Dfe978357-eacf-4be4-8ad0-93c432bc23cc.webp&sig=CqnrUrmJx7p%2BfeOqqd92/jc9J9EJ5/ZnLags6naH1Jo%3D")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SAI>(&mut v2, 88888888889000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

