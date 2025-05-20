module 0x57ce1ac214f65752608864b8ce334279702adacde79c1a2f1db897805371209::nikus {
    struct NIKUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIKUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIKUS>(arg0, 9, b"NIKUS", b"NIKUS ", b"Official 1 round: 2025 ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/74e8fd36416ae9644b9842f43596ab9fblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NIKUS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIKUS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

