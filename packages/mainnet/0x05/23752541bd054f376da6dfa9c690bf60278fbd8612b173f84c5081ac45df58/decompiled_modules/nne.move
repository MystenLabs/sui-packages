module 0x523752541bd054f376da6dfa9c690bf60278fbd8612b173f84c5081ac45df58::nne {
    struct NNE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NNE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NNE>(arg0, 9, b"NNe", b"miyp", b"goof", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/7d0f47de618d4a9ce76014a9c1836212blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NNE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NNE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

