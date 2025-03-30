module 0xc305824ded269238631ac30cb51a64b589103e8cd4a0b9a0b5ba7d6156e84d00::lu {
    struct LU has drop {
        dummy_field: bool,
    }

    fun init(arg0: LU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LU>(arg0, 9, b"Lu", b"lv", b"lvlvlvlv", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/574174d7754a56ac9c9482c343826425blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

