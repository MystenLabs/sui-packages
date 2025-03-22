module 0x81d64b5bc12a32c3aa1bf7f27293c806e141e009ccc346b98884cb771eb02241::rbs {
    struct RBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: RBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RBS>(arg0, 9, b"RBS", b"RoboSui", x"7768656e20726f626f7375692074616b6573206f7665722074686520656172746820616e64206120677265617420776172200a6c657427732073617665206f757273656c766573", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/6e1ea9a46ac738a683dbd178278aedc3blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RBS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RBS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

