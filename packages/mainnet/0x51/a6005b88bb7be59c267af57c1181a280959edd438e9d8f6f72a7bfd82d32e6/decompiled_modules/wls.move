module 0x51a6005b88bb7be59c267af57c1181a280959edd438e9d8f6f72a7bfd82d32e6::wls {
    struct WLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WLS>(arg0, 9, b"WLS", b"WolfSui", b"wolf of wall street", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/be78c8a1697bfb1aa2287d7dc8f834f4blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WLS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WLS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

