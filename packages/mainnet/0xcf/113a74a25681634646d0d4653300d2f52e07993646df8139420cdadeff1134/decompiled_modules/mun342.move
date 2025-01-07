module 0xcf113a74a25681634646d0d4653300d2f52e07993646df8139420cdadeff1134::mun342 {
    struct MUN342 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUN342, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUN342>(arg0, 9, b"Mun342", b"HP342", b"none", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/7761f952c69911fb166650f986371febblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MUN342>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUN342>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

