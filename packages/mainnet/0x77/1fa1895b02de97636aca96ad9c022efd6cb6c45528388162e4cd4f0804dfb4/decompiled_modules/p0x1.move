module 0x771fa1895b02de97636aca96ad9c022efd6cb6c45528388162e4cd4f0804dfb4::p0x1 {
    struct P0X1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: P0X1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<P0X1>(arg0, 6, b"P0x1", b"Play0x1", b"$P0x1 dedicated to Suplay ccommunity ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732797134416.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<P0X1>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<P0X1>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

