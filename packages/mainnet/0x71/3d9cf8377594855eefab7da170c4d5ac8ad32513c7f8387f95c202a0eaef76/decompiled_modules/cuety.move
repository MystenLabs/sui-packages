module 0x713d9cf8377594855eefab7da170c4d5ac8ad32513c7f8387f95c202a0eaef76::cuety {
    struct CUETY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUETY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CUETY>(arg0, 9, b"CUETY", b"Cuety", b"Cuety is Cueaty", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CUETY>(&mut v2, 9999999999000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CUETY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CUETY>>(v1);
    }

    // decompiled from Move bytecode v6
}

