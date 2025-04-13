module 0x1f9effc2f99fe9cc3a7493fa2283c3c74449d9a5623c3c0c585aada217de625f::spank {
    struct SPANK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPANK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPANK>(arg0, 9, b"SPANK", b"Spankcoin", b"Clap clap clap", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmNupg9DPDdEfwstdQnZfuuWgd2TsDUhNTYR3TA24dmx25")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SPANK>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPANK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPANK>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

