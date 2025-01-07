module 0x506810dcb8a8c05664a18dbdf2952023b324247da05c79fda0940b12bf6c3cf5::jin {
    struct JIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: JIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JIN>(arg0, 6, b"Jin", b"Sui Jin Peng", b" Jins de name, runnin de game", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20240928_132532_902_57765581bb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

