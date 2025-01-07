module 0x18c5cdbff1025da6c115582d47816264efb7264955b816f84addd7088513ed7a::swolesui {
    struct SWOLESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWOLESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWOLESUI>(arg0, 6, b"SWOLESUI", b"Swolesui", b"$SWOLESUI, the strongest and most masculine plankton in all of Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/aaa_187c41560a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWOLESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWOLESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

