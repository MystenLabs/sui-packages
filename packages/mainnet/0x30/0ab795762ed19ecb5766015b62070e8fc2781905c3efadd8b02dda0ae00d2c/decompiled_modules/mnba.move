module 0x300ab795762ed19ecb5766015b62070e8fc2781905c3efadd8b02dda0ae00d2c::mnba {
    struct MNBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MNBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MNBA>(arg0, 9, b"MNBA", b"Morningbera", b"Morningbera Morningbera Morningbera", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/6d1adfa154addd90c9ca6d2df72ef1cablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MNBA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MNBA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

