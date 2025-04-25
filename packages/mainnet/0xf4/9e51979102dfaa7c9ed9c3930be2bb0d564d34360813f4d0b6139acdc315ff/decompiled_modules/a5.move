module 0xf49e51979102dfaa7c9ed9c3930be2bb0d564d34360813f4d0b6139acdc315ff::a5 {
    struct A5 has drop {
        dummy_field: bool,
    }

    fun init(arg0: A5, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<A5>(arg0, 9, b"A5", b"A56", b"picture", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/13b2d8ee2173222cf5dbb4665c95b749blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<A5>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<A5>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

