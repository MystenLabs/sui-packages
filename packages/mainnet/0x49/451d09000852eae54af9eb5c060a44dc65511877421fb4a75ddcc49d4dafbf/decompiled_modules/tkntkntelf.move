module 0x49451d09000852eae54af9eb5c060a44dc65511877421fb4a75ddcc49d4dafbf::tkntkntelf {
    struct TKNTKNTELF has drop {
        dummy_field: bool,
    }

    fun init(arg0: TKNTKNTELF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TKNTKNTELF>(arg0, 9, b"TKNTKNTELF", b"TokenToken", b"token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/ee728e1fb534f92d892017d92f1b56bablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TKNTKNTELF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TKNTKNTELF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

