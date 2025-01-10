module 0x5804a824c60fc784f677541fc5cce6e3b0b524e2341a9fc2724a8668ae4a705e::s {
    struct S has drop {
        dummy_field: bool,
    }

    fun init(arg0: S, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<S>(arg0, 6, b"S", b"S Agent", b"With Agent S, tackle complex tasks effortlessly with smart, dynamic solutions that continuously evolve, ensuring you have the most advanced AI-driven utilities at your fingertips to enhance your strategies and achievements. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000058317_470f9889a8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<S>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<S>>(v1);
    }

    // decompiled from Move bytecode v6
}

