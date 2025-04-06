module 0x702b8f5e98a3b91e3c32c9a1429447b8f7e3820ad14a49f24e02f214e7718bac::vlz {
    struct VLZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: VLZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VLZ>(arg0, 9, b"VLZ", b"walruzz", b"just being lazy ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/2c102ccf78b63daf1369b17be0c49702blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VLZ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VLZ>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

