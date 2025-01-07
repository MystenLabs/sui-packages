module 0x1ab7244fd1057734bfa15158f7c02d92981e0f13744a5ae0f71560f3b7f3c96f::egerg {
    struct EGERG has drop {
        dummy_field: bool,
    }

    fun init(arg0: EGERG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EGERG>(arg0, 9, b"egerg", b"dfkgjnv", b"rge", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<EGERG>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EGERG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EGERG>>(v1);
    }

    // decompiled from Move bytecode v6
}

