module 0x87c65195986d16b324e12dab2f440e3b426d7f1ef9c613e0662e9fade9f9ba26::sbh {
    struct SBH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBH>(arg0, 9, b"SBH", b"sebohasan", b"5000", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/7fe85fea9b6e897699a8c09de26bf5d4blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SBH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

