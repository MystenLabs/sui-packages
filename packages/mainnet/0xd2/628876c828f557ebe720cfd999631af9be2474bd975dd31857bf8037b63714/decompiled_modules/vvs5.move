module 0xd2628876c828f557ebe720cfd999631af9be2474bd975dd31857bf8037b63714::vvs5 {
    struct VVS5 has drop {
        dummy_field: bool,
    }

    fun init(arg0: VVS5, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VVS5>(arg0, 9, b"Vvs5", b"vision 5", b"The repeating 5 year crypto profit vision strategy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/b7704c44f227b369771042a4ef440736blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VVS5>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VVS5>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

