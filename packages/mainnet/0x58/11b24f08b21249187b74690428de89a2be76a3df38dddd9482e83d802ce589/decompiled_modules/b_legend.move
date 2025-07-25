module 0x5811b24f08b21249187b74690428de89a2be76a3df38dddd9482e83d802ce589::b_legend {
    struct B_LEGEND has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_LEGEND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_LEGEND>(arg0, 9, b"bLEGEND", b"bToken LEGEND", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_LEGEND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_LEGEND>>(v1);
    }

    // decompiled from Move bytecode v6
}

