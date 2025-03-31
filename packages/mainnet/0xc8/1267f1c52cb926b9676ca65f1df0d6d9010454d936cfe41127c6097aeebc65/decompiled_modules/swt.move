module 0xc81267f1c52cb926b9676ca65f1df0d6d9010454d936cfe41127c6097aeebc65::swt {
    struct SWT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWT>(arg0, 9, b"SWT", b"sweet", b"sweeeet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/15ec5144d6b373be249f82312415ee38blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SWT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

