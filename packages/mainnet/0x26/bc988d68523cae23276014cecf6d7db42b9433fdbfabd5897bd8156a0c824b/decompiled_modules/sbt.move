module 0x26bc988d68523cae23276014cecf6d7db42b9433fdbfabd5897bd8156a0c824b::sbt {
    struct SBT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBT>(arg0, 9, b"SBT", b"Shorebirds Token", b"Come fly over SUI with us! Together we fly better and go further!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/22cd118dc07c9456047e48dec3b14b2bblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SBT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

