module 0xfdca9b5b435e80b22fa20437666ebc9aaead5009a2e0ff5a2df122efeb8f08b3::tardis {
    struct TARDIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TARDIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TARDIS>(arg0, 6, b"TARDIS", b"Tardis", b"The Tardis is the ultimate travelling machine, it can bend Time and Space, we will travel trought dimensions with it, destination is wherever you want to go, not only the moon Much further beyond!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/log_A_b8d0fa7af0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TARDIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TARDIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

