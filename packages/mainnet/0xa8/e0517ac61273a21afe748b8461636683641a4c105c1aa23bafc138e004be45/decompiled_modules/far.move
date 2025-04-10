module 0xa8e0517ac61273a21afe748b8461636683641a4c105c1aa23bafc138e004be45::far {
    struct FAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAR>(arg0, 9, b"FAR", b"FARRET", b"vgvgyv frde hyhbbtr", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/d585b961735634c35ff00402cc24be29blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

