module 0x16ef644686ecf64f8ec78caf23c684a85f94f8f111bc9d72e9aa89530fb8d25d::donk {
    struct DONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONK>(arg0, 9, b"DONK", b"DONKEY", b"Donkey token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/746e0e2f367111167150718951a83520blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DONK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

