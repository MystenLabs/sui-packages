module 0xb99e3e1f178bca04b88ba6289a95aef1cd96e7f3132f4ca107ddf1db7352e36e::eggs {
    struct EGGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: EGGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EGGS>(arg0, 9, b"EGGS", b"miss Hen", b"cheap eggs for sale", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/7d39fc74ade2eeff334f2a22af379cceblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EGGS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EGGS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

