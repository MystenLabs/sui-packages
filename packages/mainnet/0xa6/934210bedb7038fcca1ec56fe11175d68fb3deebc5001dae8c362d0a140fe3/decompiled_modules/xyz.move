module 0xa6934210bedb7038fcca1ec56fe11175d68fb3deebc5001dae8c362d0a140fe3::xyz {
    struct XYZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: XYZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XYZ>(arg0, 9, b"xyz", b"xyz", b"test xyz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://strapi-dev.scand.app/uploads/sui_c07df05f00.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<XYZ>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XYZ>>(v2, @0x29c6b6986a1d607fae0f0efcd934fd91adda350f5c7c561ec2f268b24f2f141a);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XYZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

