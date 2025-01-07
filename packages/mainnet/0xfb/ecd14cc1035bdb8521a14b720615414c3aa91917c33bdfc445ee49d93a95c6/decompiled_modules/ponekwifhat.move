module 0xfbecd14cc1035bdb8521a14b720615414c3aa91917c33bdfc445ee49d93a95c6::ponekwifhat {
    struct PONEKWIFHAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PONEKWIFHAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PONEKWIFHAT>(arg0, 9, b"PonekWifHat", b"PonekWifHat", b"Ponke meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PONEKWIFHAT>(&mut v2, 8000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PONEKWIFHAT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PONEKWIFHAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

