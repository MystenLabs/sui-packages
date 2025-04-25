module 0xdefe9b3d7075dfc3a6fcc35d7b71aac0003905dbe27faaf48fa593eb4dfaa3d4::sp {
    struct SP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SP>(arg0, 9, b"SP", b"Sparg", b"picture", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/5a673b970d439efea9c838d6b26787e9blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

