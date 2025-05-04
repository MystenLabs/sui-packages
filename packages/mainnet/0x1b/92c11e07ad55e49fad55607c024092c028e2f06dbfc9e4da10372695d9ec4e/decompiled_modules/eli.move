module 0x1b92c11e07ad55e49fad55607c024092c028e2f06dbfc9e4da10372695d9ec4e::eli {
    struct ELI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELI>(arg0, 9, b"ELI", b"Elite", b"Only Elites", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/1594a26eda602af74e5f8ef53a86e780blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ELI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

