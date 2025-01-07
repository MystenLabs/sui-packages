module 0xf0dd67b6919035223536a87540cef1e1d7799291ec66c9f02fea32b2395d2f40::suiscf {
    struct SUISCF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISCF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISCF>(arg0, 6, b"SuiSCF", b"SCF", x"54686520436875726368206f662074686520736d6f6b696e6720636869636b656e20666973682077617320616c7761797320737570706f73656420746f20626520612063687572636820666f7220746865206d6973666974732e0a0a20412063687572636820666f722074686f7365207468617420646f6e27742062656c6f6e672c2074686174206665656c20756e636f6d666f727461626c6520617420726567756c6172206368757263682c20746861742077657265206a7564676564206f72206d6164652066756e206f66206f7220636173742061736964652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/18_8f91a84717.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISCF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISCF>>(v1);
    }

    // decompiled from Move bytecode v6
}

