module 0x11444bf8b770a54d8c58f524bc52b4fa15b3489889268c1785f30bf3ce42d0af::gsc {
    struct GSC has drop {
        dummy_field: bool,
    }

    fun init(arg0: GSC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GSC>(arg0, 9, b"GSC", b"Ghostcoin", b"Ghost coin from Thailand ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/fd8840ca189f7394d59893d86616a4c3blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GSC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GSC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

