module 0x39ca193f2ec2819890736abbbdf8fb7082386cef4af0f33b7ab3267779b3a358::ditto {
    struct DITTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DITTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DITTO>(arg0, 6, b"DITTO", b"Ditto", x"446974746f203d20537569e28099732073706972697420506f6bc3a96d6f6e2e20416461707473206c696b6520736d61727420636f6e7472616374732e205472616e73666f726d73206c696b652064796e616d6963204e4654732e20436f6e6e6563747320436861696e73206c696b65206e6f7468696e6720656c73652e2057656233e280997320756c74696d617465206d696d69636b65722e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1748561334730.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DITTO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DITTO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

