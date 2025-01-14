module 0x89ea4e804fe278955954fd3e9265904227a6a1736b6069130c11fed2fd890fb8::ivy {
    struct IVY has drop {
        dummy_field: bool,
    }

    fun init(arg0: IVY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IVY>(arg0, 9, b"IVY", b"IVE III", b"adad", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump-fun-7k-dev.nysm.work/api/file-upload/b87c74af18f8a89f963e87579bc92b00blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IVY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IVY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

