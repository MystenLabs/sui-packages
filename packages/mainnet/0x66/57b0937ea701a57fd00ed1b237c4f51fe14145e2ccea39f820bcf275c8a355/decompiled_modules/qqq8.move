module 0x6657b0937ea701a57fd00ed1b237c4f51fe14145e2ccea39f820bcf275c8a355::qqq8 {
    struct QQQ8 has drop {
        dummy_field: bool,
    }

    fun init(arg0: QQQ8, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QQQ8>(arg0, 9, b"QQQ8", b"YYY888", b" Deep Search Think", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/a0f08eb315d8236ebfb9e4bafb097b64blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QQQ8>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QQQ8>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

