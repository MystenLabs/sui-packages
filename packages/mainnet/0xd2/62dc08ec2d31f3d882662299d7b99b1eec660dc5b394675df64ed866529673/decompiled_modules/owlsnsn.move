module 0xd262dc08ec2d31f3d882662299d7b99b1eec660dc5b394675df64ed866529673::owlsnsn {
    struct OWLSNSN has drop {
        dummy_field: bool,
    }

    fun init(arg0: OWLSNSN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OWLSNSN>(arg0, 9, b"OWLSNSN", b"shiwme", b"eijdj", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/beea603c-c6b8-482f-a679-8240ee46fbfa.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OWLSNSN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OWLSNSN>>(v1);
    }

    // decompiled from Move bytecode v6
}

