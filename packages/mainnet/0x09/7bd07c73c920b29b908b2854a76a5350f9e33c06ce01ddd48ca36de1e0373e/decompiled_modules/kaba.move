module 0x97bd07c73c920b29b908b2854a76a5350f9e33c06ce01ddd48ca36de1e0373e::kaba {
    struct KABA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KABA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KABA>(arg0, 6, b"KABA", b"Japan's Moo Deng", x"284b616261293a2042656c69657665206974206f72206e6f742c20746865736520686970706f20626f61747320617265205245414c212054686579206372756973652074686520776174657273206f66204a6170616e2c20616e64206e6f7720746865792772652074616b696e67206f7665722074686520696e7465726e657420617320746865206e6577657374206d656d652073656e736174696f6e2e2047657420726561647920666f7220637574656e657373206f7665726c6f6164207769746820284b61626129210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/532112312131231_719302e780.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KABA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KABA>>(v1);
    }

    // decompiled from Move bytecode v6
}

