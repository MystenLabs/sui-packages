module 0xc430454d02920a4ce50126bc664fed24c5028433c375a44bddd22ff0e5fe2c42::qggh {
    struct QGGH has drop {
        dummy_field: bool,
    }

    fun init(arg0: QGGH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QGGH>(arg0, 9, b"Qggh", b"trshstyhrt", b"tyydhdj", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/0fb072cf28d940136b65be4b71416118blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QGGH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QGGH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

