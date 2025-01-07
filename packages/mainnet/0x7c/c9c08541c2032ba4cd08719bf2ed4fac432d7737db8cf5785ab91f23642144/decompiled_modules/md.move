module 0x7cc9c08541c2032ba4cd08719bf2ed4fac432d7737db8cf5785ab91f23642144::md {
    struct MD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MD>(arg0, 9, b"MD", b"Maple the Dachshund", b"Our beloved Maple is 1 year old today, so I thought I'd launch a meme to celebrate and in her honour, may she live on forever!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ibb.co/8XXtNxQ")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MD>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MD>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MD>>(v1);
    }

    // decompiled from Move bytecode v6
}

