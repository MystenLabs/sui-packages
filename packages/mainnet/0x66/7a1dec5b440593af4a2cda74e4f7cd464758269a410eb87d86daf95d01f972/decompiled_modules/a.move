module 0x667a1dec5b440593af4a2cda74e4f7cd464758269a410eb87d86daf95d01f972::a {
    struct A has drop {
        dummy_field: bool,
    }

    fun init(arg0: A, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<A>(arg0, 9, b"A", b"A43", b"picture", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/5f2dc0ff80a6d37212e6433680948932blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<A>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<A>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

