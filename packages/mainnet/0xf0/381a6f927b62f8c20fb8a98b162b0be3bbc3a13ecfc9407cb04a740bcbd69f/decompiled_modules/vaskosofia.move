module 0xf0381a6f927b62f8c20fb8a98b162b0be3bbc3a13ecfc9407cb04a740bcbd69f::vaskosofia {
    struct VASKOSOFIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: VASKOSOFIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VASKOSOFIA>(arg0, 9, b"vaskosofia", b"vaskosofia", b"hakunabratemee", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<VASKOSOFIA>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VASKOSOFIA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VASKOSOFIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

