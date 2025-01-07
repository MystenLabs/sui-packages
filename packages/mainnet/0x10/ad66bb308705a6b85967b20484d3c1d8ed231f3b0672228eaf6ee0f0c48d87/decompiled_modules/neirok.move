module 0x10ad66bb308705a6b85967b20484d3c1d8ed231f3b0672228eaf6ee0f0c48d87::neirok {
    struct NEIROK has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEIROK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEIROK>(arg0, 6, b"NEIROK", b"neiro grok", b"NEIRO GROK ON SUI NETWORK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/23423423_149d119b36.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEIROK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEIROK>>(v1);
    }

    // decompiled from Move bytecode v6
}

