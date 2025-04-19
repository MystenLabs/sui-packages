module 0xeb5269c5491731aac00517bc35be8273e1ac31d5465b2beb62467b04ef91c37e::gari {
    struct GARI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GARI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GARI>(arg0, 9, b"GARI", b"Garibaldi", b"A nice guy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/9d72c37ba6494ae3aa1c1c25e56ad576blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GARI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GARI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

