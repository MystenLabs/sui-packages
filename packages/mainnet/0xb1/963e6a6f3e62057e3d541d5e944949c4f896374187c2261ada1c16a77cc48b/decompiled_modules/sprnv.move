module 0xb1963e6a6f3e62057e3d541d5e944949c4f896374187c2261ada1c16a77cc48b::sprnv {
    struct SPRNV has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPRNV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPRNV>(arg0, 6, b"SPRNV", b"SUI-PERNOVA", x"2061206d656d652d776f72746879206e616d652074686174206578706c6f73697665206f72206f75742d6f662d746869732d776f726c6420696e20612068756d6f726f7573207761792e204974e2809973206120706c6179206f6e20746865206d656d652063756c7475726520746861742074687269766573206f6e20756e6578706563746564206d6173682d75707321", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732197433819.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPRNV>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPRNV>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

