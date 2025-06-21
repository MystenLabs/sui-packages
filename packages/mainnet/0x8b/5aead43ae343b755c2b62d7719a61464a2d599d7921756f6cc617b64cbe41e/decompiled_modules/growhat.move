module 0x8b5aead43ae343b755c2b62d7719a61464a2d599d7921756f6cc617b64cbe41e::growhat {
    struct GROWHAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GROWHAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GROWHAT>(arg0, 8, b"GROWHAT", b"GORBAGANA WIFHAT", x"474f52424147414e412069736ee280997420796f7572206176657261676520636861726163746572", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.slaunch.xyz/assets/tokens/20b82c45-9858-481c-9ac1-40debff2b5c2.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GROWHAT>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GROWHAT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GROWHAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

