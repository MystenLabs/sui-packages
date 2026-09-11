module 0x340f8b97d29c533b1b46fb1a7f2e4e4821b306300f5f24258556dab6cecabb6e::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"06574e4f5445530857616c4e6f746573e101447261672d616e642d64726f70206e6f7465732c20626f6f6b6d61726b7320616e64207461736b7320e280942073796e636564206c6976652c206261636b656420757020746f20646563656e7472616c697a65642057616c7275732073746f726167652c20616e64207472756c7920796f7572732e7c7c7b2274656c656772616d223a2268747470733a2f2f77616c6e6f7465732e78797a2f222c2274776974746572223a2268747470733a2f2f782e636f6d2f77616c5f6e6f746573222c2277656273697465223a2268747470733a2f2f77616c6e6f7465732e78797a2f227d2068747470733a2f2f692e696d6775722e636f6d2f426851733266332e6a706567");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

