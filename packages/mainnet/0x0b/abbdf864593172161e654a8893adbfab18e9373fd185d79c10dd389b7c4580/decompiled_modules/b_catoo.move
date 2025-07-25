module 0xbabbdf864593172161e654a8893adbfab18e9373fd185d79c10dd389b7c4580::b_catoo {
    struct B_CATOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_CATOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_CATOO>(arg0, 9, b"bCATOO", b"bToken CATOO", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_CATOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_CATOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

