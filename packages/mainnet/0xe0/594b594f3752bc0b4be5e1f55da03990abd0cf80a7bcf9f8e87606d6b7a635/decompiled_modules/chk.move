module 0xe0594b594f3752bc0b4be5e1f55da03990abd0cf80a7bcf9f8e87606d6b7a635::chk {
    struct CHK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHK>(arg0, 9, b"CHK", b"consensus hk", b"A token for the Consensus Hong Kong community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CHK>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHK>>(v1);
    }

    // decompiled from Move bytecode v6
}

