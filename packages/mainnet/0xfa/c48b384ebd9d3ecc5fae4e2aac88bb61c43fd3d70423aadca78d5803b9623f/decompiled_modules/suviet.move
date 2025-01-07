module 0xfac48b384ebd9d3ecc5fae4e2aac88bb61c43fd3d70423aadca78d5803b9623f::suviet {
    struct SUVIET has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUVIET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUVIET>(arg0, 6, b"SUVIET", b"SUVIET UNION", x"5448452053555649455420554e494f4e20444f4553204e4f542041434b4e4f574c4544474520534f4349414c532e0a464f525741524420544f20455445524e414c20474c4f52592c20434f4d524144455321", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUIVIET_1400787d3f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUVIET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUVIET>>(v1);
    }

    // decompiled from Move bytecode v6
}

