module 0xb6e92da8214ac41e4a39667e8df472dc9e54d917421ea2c6ae4c4045c2e26086::dyui {
    struct DYUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DYUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DYUI>(arg0, 9, b"DYUI", b"dyulk", b"hsr", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/c2f466b1d28555f10a884ebff17d2f97blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DYUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DYUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

