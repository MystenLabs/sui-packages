module 0x7922952de8019ffcf57fa00e896dcb748cf509d11ef868199868a9f29c5fe089::mikey {
    struct MIKEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIKEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIKEY>(arg0, 9, b"MIKEY", b"MikeyToken", b"A token for the Mikey community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MIKEY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIKEY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIKEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

