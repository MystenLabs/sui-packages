module 0x80f4383193ca79e1cf7ded90856b37d577ff7a2ed0f8c70aad1337a6040fc23e::chillcu {
    struct CHILLCU has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLCU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLCU>(arg0, 9, b"CHILLCU", b"CHILLCUU On SUI", b"CHILLCUU On SUI Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be-alpha.7k.fun/api/file-upload/b0e4460f87f32a1570e56eb4609f0e67blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHILLCU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLCU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

