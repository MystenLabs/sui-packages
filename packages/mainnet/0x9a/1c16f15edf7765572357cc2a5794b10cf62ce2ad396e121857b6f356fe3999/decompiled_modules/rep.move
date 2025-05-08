module 0x9a1c16f15edf7765572357cc2a5794b10cf62ce2ad396e121857b6f356fe3999::rep {
    struct REP has drop {
        dummy_field: bool,
    }

    fun init(arg0: REP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REP>(arg0, 9, b"REP", b"REP #SUI", b"REP ON #SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/0f4c6e453ce98704b81a4ec5f4ccbaaablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<REP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

