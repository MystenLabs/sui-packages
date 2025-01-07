module 0x434f187cd7725783b7497e8354838acbc92f7c12e82069736ebe5e6530a7b00::mascat {
    struct MASCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MASCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MASCAT>(arg0, 6, b"MASCAT", b"Mask Cat", b" Hi there, its me   Mask Cat! Once, I was just a tiny, scrappy furball left all alone in the big, scary world. But guess what? I fought back! Now, Im more", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000020410_e53eb88343.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MASCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MASCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

