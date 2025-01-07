module 0xb262af8e7672953b81826bda2b67041725eb9eec0d39e3e511f00701a641eedd::pepa {
    struct PEPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPA>(arg0, 9, b"PEPA", b"Frosch", b"Memcoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b98f59d2-4c67-4c79-9eb9-2ec1c2342c4e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPA>>(v1);
    }

    // decompiled from Move bytecode v6
}

