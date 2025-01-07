module 0x3ebc41c8c65615823a92648ab99c8b19e4c7a2a2890ad231322830d36303af8e::ckc {
    struct CKC has drop {
        dummy_field: bool,
    }

    fun init(arg0: CKC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CKC>(arg0, 6, b"CKC", b"CookieCoin", b"Do you accept a cookie that comes out of the oven very warm?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731099218701.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CKC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CKC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

