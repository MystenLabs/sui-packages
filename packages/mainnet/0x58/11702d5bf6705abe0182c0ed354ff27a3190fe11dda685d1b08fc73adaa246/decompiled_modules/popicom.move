module 0x5811702d5bf6705abe0182c0ed354ff27a3190fe11dda685d1b08fc73adaa246::popicom {
    struct POPICOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPICOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPICOM>(arg0, 9, b"POPICOM", b"coinpop", b"new mem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/48aacffc009fa05f9c4c0ee61bfa2591blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POPICOM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPICOM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

