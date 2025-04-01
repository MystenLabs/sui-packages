module 0xd4157f1c61cfa3dc700ef956aa3f5d326bd8fcd49c54aeb5b32b404b96689285::pnd {
    struct PND has drop {
        dummy_field: bool,
    }

    fun init(arg0: PND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PND>(arg0, 9, b"PND", b"Ponad", b"POnna + Nad", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/1250367bb57c2dd078c6a533fa3127c3blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PND>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PND>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

