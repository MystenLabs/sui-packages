module 0xeac64e19c599995a24d9daecb55bce676966d889ec42e046816b2aa379851e9c::cba {
    struct CBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CBA>(arg0, 9, b"CBA", b"Bac169", b"NFT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/a8f0109f475f6ace40473381a4e0d1b8blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CBA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CBA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

