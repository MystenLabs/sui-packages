module 0xc15f93ecbdf0df5f727dd25ae75859afd6f8966f4f3c88fd323d1cc62fc59dd7::wt {
    struct WT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WT>(arg0, 9, b"WT", b"Water", b"j", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/3c8bc9d6d5146b3d4c2c9877ebce2a21blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

