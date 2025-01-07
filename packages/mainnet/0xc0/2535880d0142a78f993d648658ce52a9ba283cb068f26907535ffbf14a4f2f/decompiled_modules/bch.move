module 0xc02535880d0142a78f993d648658ce52a9ba283cb068f26907535ffbf14a4f2f::bch {
    struct BCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: BCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BCH>(arg0, 9, b"BCH", b"Bitcoin Cash", b"Half dog, half Walrus, 100% moon-bound Half dog, half Walrus, 100% moon-bound Half dog, half Walrus, 100% moon-bound Half dog, half Walrus, 100% moon-bound Half dog, half Walrus, 100% moon-bound Half dog, half Walrus, 100% moon-bound Half dog, half Walrus, 100% moon-bound", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump-fun-7k-dev.nysm.work/api/file-upload/a04ba908dca4b0ce0a1ed47ea26a79e9blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BCH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BCH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

