module 0xf20e81e0417ff3f527966ac017e79c2b3f9d99c53208c4d416b06f9ec28a499a::fatshit {
    struct FATSHIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FATSHIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FATSHIT>(arg0, 9, b"FATSHIT", b"FATSHIT", b"a big fat shit - don't", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FATSHIT>(&mut v2, 6000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FATSHIT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FATSHIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

