module 0x9c6eacddef5c6d24e05efb1f76ad2bf3e9246eba1d98bc47ac89b35baf53532a::dmb {
    struct DMB has drop {
        dummy_field: bool,
    }

    fun init(arg0: DMB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DMB>(arg0, 9, b"Dmb", b"dumb", b"dumb dumb", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/8d39f4494ecb815fef2203e0ed1bfc39blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DMB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DMB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

