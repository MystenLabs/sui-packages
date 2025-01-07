module 0x71641b307b46815cf5fc0fd3e3dea9479c4e05b173204f3906c4ebc043650d27::nahui {
    struct NAHUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAHUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAHUI>(arg0, 9, b"NAHUI", x"d098d094d09820d09dd090d0a5d0a3d099", x"d098d094d09820d09dd090d0a5d0a3d09920d09bd09ed0a5", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://is1-ssl.mzstatic.com/image/thumb/Music116/v4/f1/d4/97/f1d4974a-86a7-3b15-00c5-4419ceff3319/4039967255105_cover.jpg/1200x1200bb.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NAHUI>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAHUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NAHUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

