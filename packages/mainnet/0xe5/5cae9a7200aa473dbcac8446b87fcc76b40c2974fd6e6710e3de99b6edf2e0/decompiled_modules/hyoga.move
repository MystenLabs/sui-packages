module 0xe55cae9a7200aa473dbcac8446b87fcc76b40c2974fd6e6710e3de99b6edf2e0::hyoga {
    struct HYOGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HYOGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HYOGA>(arg0, 6, b"HYOGA", b"SUISNE HYOGA", x"48594f474120206973206f6e65206f6620746865206d61696e2063686172616374657273206f6620746865206d616e676120616e6420616e696d65205361696e742053656979612e0a4143434f4d50414e592048494d20494e5349444520544849532049435920574f524c442c20414e442048454c502048494d2057494e20544845204441494c5920424154544c455320414741494e5354204d454d45532e20495427532054494d4520544f2052455355525245435420414c4c20544845204c4547454e4453204c494b452048594f474120544f20434c45414e53452054484520574542204f4e434520414e4420464f5220414c4c2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/e7d295540f74937fc89ac3d0fecc0a1d_anime_saint_bronze_a93b7f14f0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HYOGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HYOGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

