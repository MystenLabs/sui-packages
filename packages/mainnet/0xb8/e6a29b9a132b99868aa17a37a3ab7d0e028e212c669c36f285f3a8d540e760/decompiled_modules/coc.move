module 0xb8e6a29b9a132b99868aa17a37a3ab7d0e028e212c669c36f285f3a8d540e760::coc {
    struct COC has drop {
        dummy_field: bool,
    }

    fun init(arg0: COC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COC>(arg0, 3, b"COC", b"CocCoin", b"Male Based Cryptocurrency", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<COC>(&mut v2, 4100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COC>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COC>>(v1);
    }

    // decompiled from Move bytecode v6
}

