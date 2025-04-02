module 0xc932d3987d1a903de67babc4f62c7a2a97bad9ebbe4c253aff57ff10b23ab53d::le {
    struct LE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LE>(arg0, 9, b"Le", b"lemonad", b"lemonad ad ad ad", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/73471b491289aafd0a37d0ea29ef2ea6blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

