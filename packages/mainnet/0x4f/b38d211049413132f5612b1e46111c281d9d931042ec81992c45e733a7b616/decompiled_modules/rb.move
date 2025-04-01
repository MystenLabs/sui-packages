module 0x4fb38d211049413132f5612b1e46111c281d9d931042ec81992c45e733a7b616::rb {
    struct RB has drop {
        dummy_field: bool,
    }

    fun init(arg0: RB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RB>(arg0, 9, b"RB", b"rabbit", b"Rabbit or cat?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/b4b9cbccae20f9f1c62a6a559e8423b0blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

