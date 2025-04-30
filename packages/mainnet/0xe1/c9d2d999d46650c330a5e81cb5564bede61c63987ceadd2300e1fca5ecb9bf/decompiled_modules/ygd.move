module 0xe1c9d2d999d46650c330a5e81cb5564bede61c63987ceadd2300e1fca5ecb9bf::ygd {
    struct YGD has drop {
        dummy_field: bool,
    }

    fun init(arg0: YGD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YGD>(arg0, 9, b"YGD", b"YoungD No1", b"Researcher at 5 Phut Crypto", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/9cafe4c3ac015acecc13eabeceb72e0eblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YGD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YGD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

