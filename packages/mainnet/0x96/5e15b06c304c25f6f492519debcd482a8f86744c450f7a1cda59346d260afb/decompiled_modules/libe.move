module 0x965e15b06c304c25f6f492519debcd482a8f86744c450f7a1cda59346d260afb::libe {
    struct LIBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIBE>(arg0, 9, b"LIBE", b"Liberty", b"This is a coin that can show you how to be free.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/5f45ef7d661fb2da2710e28f41cbd6b6blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LIBE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIBE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

