module 0x30b0179b974b5f88244537800efc7307068813c2735e1b1df4da847309ba08a1::kst {
    struct KST has drop {
        dummy_field: bool,
    }

    fun init(arg0: KST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KST>(arg0, 9, b"KST", b"Kostas", b"Sobre a minha gata Luna", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/29d1eb249bba27468755bf45be4c1a11blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KST>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

