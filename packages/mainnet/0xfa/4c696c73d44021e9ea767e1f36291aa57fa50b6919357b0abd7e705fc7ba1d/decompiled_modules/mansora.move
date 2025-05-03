module 0xfa4c696c73d44021e9ea767e1f36291aa57fa50b6919357b0abd7e705fc7ba1d::mansora {
    struct MANSORA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MANSORA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MANSORA>(arg0, 9, b"MANSORA", b"MANSOR Angry", b"KONTOOLLL!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/c3b9ce8a5eb55f9b7b91321a6a87b097blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MANSORA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MANSORA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

