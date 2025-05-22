module 0x8c1b51c5494110217ee0434686e97e98b521489f580dd74df292b8426c821bfc::dfddd {
    struct DFDDD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DFDDD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DFDDD>(arg0, 9, b"DFDDD", b"AAS", b"sfsdfsdf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dev-file-walletapp.waveonsui.com/images/wave-pumps/7335edcc-56e7-4ee0-af83-dc0ca74da3ec.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DFDDD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DFDDD>>(v1);
    }

    // decompiled from Move bytecode v6
}

