module 0x229003a84bcee3fa8862b7465fb8fb7054f5908c778c650e75b3da527d3e9594::shep {
    struct SHEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHEP>(arg0, 9, b"SHEP", b"SUI Shepherd", b"Come join the fun with the Sui Shepherd GSD!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/3dcd945869635febb1a1472b0dc75430blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHEP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHEP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

