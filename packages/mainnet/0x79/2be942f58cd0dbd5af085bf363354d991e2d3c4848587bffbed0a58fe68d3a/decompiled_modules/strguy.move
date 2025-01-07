module 0x792be942f58cd0dbd5af085bf363354d991e2d3c4848587bffbed0a58fe68d3a::strguy {
    struct STRGUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: STRGUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STRGUY>(arg0, 9, b"STRGUY", b"STRESS GUY", b"STRESS CRYPTO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/48a6986866af3dfcf4ba3667bce48789blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STRGUY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STRGUY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

