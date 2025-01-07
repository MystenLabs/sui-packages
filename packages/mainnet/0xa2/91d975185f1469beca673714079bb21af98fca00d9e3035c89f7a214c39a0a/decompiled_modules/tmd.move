module 0xa291d975185f1469beca673714079bb21af98fca00d9e3035c89f7a214c39a0a::tmd {
    struct TMD has drop {
        dummy_field: bool,
    }

    fun init(arg0: TMD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TMD>(arg0, 9, b"TMD", b"The Mighty Dragon", x"546865204d696768747920447261676f6e206973206120706f77657266756c20616e64206d616a657374696320637265617475726520746861742073796d626f6c697a657320737472656e6774682c20776973646f6d20616e642074686520706f776572206f66206e61747572652e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/412425610adb42147164533ec8842bd2blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TMD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TMD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

