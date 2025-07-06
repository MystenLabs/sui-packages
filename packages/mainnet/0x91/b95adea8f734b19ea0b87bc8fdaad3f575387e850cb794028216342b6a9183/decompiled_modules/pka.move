module 0x91b95adea8f734b19ea0b87bc8fdaad3f575387e850cb794028216342b6a9183::pka {
    struct PKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PKA>(arg0, 9, b"PKA", b"pikachu", b"i like pikachu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/2dc449c705487079467f19a1f96ee3a4blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PKA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PKA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

