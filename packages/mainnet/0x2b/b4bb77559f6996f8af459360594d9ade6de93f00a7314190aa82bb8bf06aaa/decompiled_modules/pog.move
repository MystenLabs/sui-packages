module 0x2bb4bb77559f6996f8af459360594d9ade6de93f00a7314190aa82bb8bf06aaa::pog {
    struct POG has drop {
        dummy_field: bool,
    }

    fun init(arg0: POG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POG>(arg0, 6, b"POG", b"Punk Dog", b"Punk Dog, legendary Dog prepare for x1000 no socials send it", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000005749_3ab6f68854.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POG>>(v1);
    }

    // decompiled from Move bytecode v6
}

