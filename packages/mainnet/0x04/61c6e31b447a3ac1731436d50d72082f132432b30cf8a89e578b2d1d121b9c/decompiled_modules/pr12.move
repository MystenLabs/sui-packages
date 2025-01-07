module 0x461c6e31b447a3ac1731436d50d72082f132432b30cf8a89e578b2d1d121b9c::pr12 {
    struct PR12 has drop {
        dummy_field: bool,
    }

    fun init(arg0: PR12, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PR12>(arg0, 9, b"PR12", b"xx1", b"sui sui sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/3da25339028b367031a4ee4caf9c339cblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PR12>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PR12>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

