module 0x8d9776627eef22d9a67cfe0abcc84bdd587bb64525f550a8a3dc397f6c6e07e9::ius {
    struct IUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: IUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IUS>(arg0, 9, b"IUS", b"IUS Digit'all", x"42657374205355492072657665727369626c6520746f6b656e2021200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/8db9f6e36601fdec47b00c152995ca4fblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IUS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IUS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

