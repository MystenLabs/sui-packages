module 0x8d076a01c79b64bbcecf3b0ea3483eb76424833b0c4c75186692528a6b98621::bubi {
    struct BUBI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBI>(arg0, 9, b"Bubi", b"Bubu", b"Bubi bubu in the bubu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BUBI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUBI>>(v1);
    }

    // decompiled from Move bytecode v6
}

