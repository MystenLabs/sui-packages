module 0x8b04034b2b313e918ec5963b86a67427475d25b9797f0a6bed83e4e416aff9a4::bssui {
    struct BSSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSSUI>(arg0, 6, b"BSSUI", b"BitShiba SUI", b"Tele: https://t.me/bitshib_sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/tAgpk8F.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BSSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSSUI>>(v0, @0x8bc7769c39da777823cc9360f196c49837921b4efa5daca7f63d3d9e2f501a09);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BSSUI>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BSSUI>(arg0, arg2, arg1, arg3);
    }

    // decompiled from Move bytecode v6
}

