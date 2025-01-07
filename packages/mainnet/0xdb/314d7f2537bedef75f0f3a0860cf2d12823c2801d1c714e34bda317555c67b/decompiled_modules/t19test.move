module 0xdb314d7f2537bedef75f0f3a0860cf2d12823c2801d1c714e34bda317555c67b::t19test {
    struct T19TEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: T19TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T19TEST>(arg0, 4, b"T19TEST", b"T19TEST", b"Fun Meme Token without Value", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR4nGNgYAAAAAMAASsJTYQAAAAASUVORK5CYII=")), arg1);
        let v2 = v0;
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<T19TEST>>(v1);
        0x2::coin::mint_and_transfer<T19TEST>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T19TEST>>(v2, @0x0);
    }

    public fun transfer_to_burn_address(arg0: 0x2::coin::Coin<T19TEST>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T19TEST>>(arg0, @0x0);
    }

    // decompiled from Move bytecode v6
}

