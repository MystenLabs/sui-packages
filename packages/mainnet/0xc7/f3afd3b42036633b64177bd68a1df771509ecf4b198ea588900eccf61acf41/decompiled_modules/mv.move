module 0xc7f3afd3b42036633b64177bd68a1df771509ecf4b198ea588900eccf61acf41::mv {
    struct MV has drop {
        dummy_field: bool,
    }

    fun init(arg0: MV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MV>(arg0, 9, b"MV", b"Move", b"Official Meme of the Movement Labs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/38395d80745860c1d7b204fbb6cde549blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MV>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MV>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

