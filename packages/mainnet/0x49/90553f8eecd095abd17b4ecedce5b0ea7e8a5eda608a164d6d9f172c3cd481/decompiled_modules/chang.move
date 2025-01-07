module 0x4990553f8eecd095abd17b4ecedce5b0ea7e8a5eda608a164d6d9f172c3cd481::chang {
    struct CHANG has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHANG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHANG>(arg0, 6, b"CHANG", b"evanchang", b"Ride the blue wave with Evan Chang", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Evan_Chang_58b6ac5c7f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHANG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHANG>>(v1);
    }

    // decompiled from Move bytecode v6
}

