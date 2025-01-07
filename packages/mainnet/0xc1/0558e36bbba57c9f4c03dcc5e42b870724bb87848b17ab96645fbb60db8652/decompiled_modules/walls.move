module 0xc10558e36bbba57c9f4c03dcc5e42b870724bb87848b17ab96645fbb60db8652::walls {
    struct WALLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WALLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WALLS>(arg0, 6, b"WALLS", b"Wall sui Boys", b"Wolf of wall street wolfs launching on movepump ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000027953_85457f6e51.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WALLS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WALLS>>(v1);
    }

    // decompiled from Move bytecode v6
}

