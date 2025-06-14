module 0xa7b269fb405f3b9105e508634d922b6e6266f6152858f4ad407a205e65325eb7::gucci {
    struct GUCCI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUCCI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUCCI>(arg0, 9, b"GUCCI", b"$GUCCI", b"Gucci token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/837921c03d8265b95e2938d9c72e5ba4blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GUCCI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUCCI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

