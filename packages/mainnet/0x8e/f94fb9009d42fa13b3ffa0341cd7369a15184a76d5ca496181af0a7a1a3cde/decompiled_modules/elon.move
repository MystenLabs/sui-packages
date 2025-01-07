module 0x8ef94fb9009d42fa13b3ffa0341cd7369a15184a76d5ca496181af0a7a1a3cde::elon {
    struct ELON has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELON>(arg0, 9, b"ELON", b"ELON SHOOT on 7K", x"54686520526967687420746f20426561722041726d73206f6e20687474703a2f2f374b2e66756e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/1ff2e0835ce1b004f4665ecf525419a6blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ELON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELON>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

