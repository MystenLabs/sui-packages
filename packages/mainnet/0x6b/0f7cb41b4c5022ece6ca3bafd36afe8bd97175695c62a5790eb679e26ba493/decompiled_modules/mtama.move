module 0x6b0f7cb41b4c5022ece6ca3bafd36afe8bd97175695c62a5790eb679e26ba493::mtama {
    struct MTAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MTAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MTAMA>(arg0, 9, b"MTAMA", b"Micro Suitama", b"Tama", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MTAMA>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MTAMA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MTAMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

