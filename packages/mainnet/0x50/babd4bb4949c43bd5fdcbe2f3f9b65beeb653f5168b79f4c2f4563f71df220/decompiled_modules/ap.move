module 0x50babd4bb4949c43bd5fdcbe2f3f9b65beeb653f5168b79f4c2f4563f71df220::ap {
    struct AP has drop {
        dummy_field: bool,
    }

    fun init(arg0: AP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AP>(arg0, 9, b"AP", b"artespraticas", b"My fun token :-)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/3d09f2f2c5acdaa45bf3190863579c2eblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

