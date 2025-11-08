module 0xdee15d1021e46810c903db81349e1bbd149232ff3fa1220706c199990c6c98d3::readwell {
    struct READWELL has drop {
        dummy_field: bool,
    }

    fun init(arg0: READWELL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<READWELL>(arg0, 9, b"Readwell", b"Readwell", b"Coin for Education", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kellercenter.princeton.edu/sites/default/files/styles/free_style/public/images/eLab%202022%20-%20Readwell%20-%20Logo%202.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<READWELL>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<READWELL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<READWELL>>(v1);
    }

    // decompiled from Move bytecode v6
}

