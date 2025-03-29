module 0x1d491fb4dc5222749dd70fe4d7ae138884ed5b9024e93ff702bf8d6b05442314::mon {
    struct MON has drop {
        dummy_field: bool,
    }

    fun init(arg0: MON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MON>(arg0, 9, b"Mon", b"Monad", b"First Mon on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/f5ddab29ae68eabe97d3a5c949dc21c7blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MON>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

