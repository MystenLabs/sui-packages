module 0x976dfcbe56966dc88e7f93af402e5c285c2daf7131831677faf616f7e15317b::trustmefun {
    struct TRUSTMEFUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUSTMEFUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUSTMEFUN>(arg0, 9, b"TRUSTMEFUN", b"TRUSTMEE", b"TRUSTME", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/cf27285d6835eafa1ba8670fc9398955blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUSTMEFUN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUSTMEFUN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

