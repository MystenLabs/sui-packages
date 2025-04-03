module 0x3580c40339615c199efa9fef68a61037d1a256ddc991823a98b980d3344e88f2::cc {
    struct CC has drop {
        dummy_field: bool,
    }

    fun init(arg0: CC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CC>(arg0, 9, b"CC", b"Crypto Club", x"42c3bc79c3bc6b20746f706c756c756b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/aed723a1b94fe41ae7cb234891b86ba2blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

