module 0xbd4c1331289d4b8a0b36a617f722eb4a1844c47bba147e4b453782b4fac74aae::pvp {
    struct PVP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PVP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PVP>(arg0, 9, b"PVP", b"PVP", b"Person vs Person", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.dzeninfra.ru/get-zen_doc/10191615/pub_64fde1d7ff2f8a478a5af08f_64fde1e240159a051a8e1ee2/scale_1200")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PVP>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PVP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PVP>>(v1);
    }

    // decompiled from Move bytecode v6
}

