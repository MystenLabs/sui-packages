module 0x100ed02ed05ff3638b8712a1ddf35256d4ff82404e8f4d4459fbc8ff3109e128::gari {
    struct GARI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GARI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GARI>(arg0, 9, b"GARI", b"Garibaldi", b"A nice guy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/a99a351b8ba11feb126760b30e87f98ablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GARI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GARI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

