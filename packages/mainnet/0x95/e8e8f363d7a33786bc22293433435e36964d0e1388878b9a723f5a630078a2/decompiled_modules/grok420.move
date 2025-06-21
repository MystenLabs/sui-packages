module 0x95e8e8f363d7a33786bc22293433435e36964d0e1388878b9a723f5a630078a2::grok420 {
    struct GROK420 has drop {
        dummy_field: bool,
    }

    fun init(arg0: GROK420, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GROK420>(arg0, 8, b"Grok420", b"Grok 4.20", b"Grok 4.20  on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.slaunch.xyz/assets/tokens/f031b67d-59a3-4cec-bd29-ea1cb27d7c74.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GROK420>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GROK420>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GROK420>>(v1);
    }

    // decompiled from Move bytecode v6
}

