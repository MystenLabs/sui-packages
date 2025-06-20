module 0x5cf71ac8df7ade19972b219d607ceaae6df03f0e7066c99854cab035b18d7cc9::smg {
    struct SMG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMG>(arg0, 9, b"SMG", b"SMOG", b"SMOG-DOG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/0530ab3a1d56e42a56c3af75d192671bblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SMG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

