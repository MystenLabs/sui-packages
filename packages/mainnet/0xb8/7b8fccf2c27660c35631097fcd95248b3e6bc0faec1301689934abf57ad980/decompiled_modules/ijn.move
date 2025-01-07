module 0xb87b8fccf2c27660c35631097fcd95248b3e6bc0faec1301689934abf57ad980::ijn {
    struct IJN has drop {
        dummy_field: bool,
    }

    fun init(arg0: IJN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IJN>(arg0, 6, b"ijn", b"oinoj", b"npin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<IJN>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IJN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IJN>>(v1);
    }

    // decompiled from Move bytecode v6
}

